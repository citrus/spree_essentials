class PostsController < Spree::BaseController

  helper :products
  
  before_filter :get_sidebar, :only => [:index, :search, :show]

  #def index 
  #  @posts = Post.live.includes(:images).paginate(:all, :page => params[:page])
  #end
  
  
  def index
    @posts_by_month = Post.find(:all, :conditions => { :live => true }, :limit => 50, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
    
    scope = Post.includes(:images).order("posted_at DESC")
    
    if params[:year].present?
      year  = params[:year].to_i
      month = 1
      day   = 1  
      if has_month = params[:month].present?
        if has_day = params[:day].present?
          day  = params[:day].to_i
        end
        month = params[:month].to_i
      end
      
      start = Date.new(year, month, day)
      stop  = start + 1.year
      
      if has_month
        stop = start + 1.month
        if has_day
          stop = start + 1.day
        end
      end    
    
      
      
      
      #Time.now.at_beginning_of_day
      
    end
    
    scope = scope.where("posted_at > ? AND posted_at <= ?", start, stop)
    
    #scope = scope.where("day(posted_at) = ?",   params[:day]) if params[:day].present?
    #scope = scope.where("month(posted_at) = ?", params[:month]) if params[:month].present?
    #scope = scope.where("year(posted_at) = ?",  params[:year]) if params[:year].present?
    
    @posts = scope.paginate(:page => params[:page])
  end
  
  
  def search
		query = params[:query].gsub(/%46/, '.')	
		@posts = Post.live.tagged_with(query).paginate(:page => params[:page])
		get_tags		
		render :template => 'posts/index'
	end
	
  def show
    @post = Post.live.includes(:tags, :images, :products).find_by_path(params[:id]) rescue nil
    return redirect_to archive_posts_path unless @post
  end
  
	def archive
		@posts = Post.live.all
	end
  
  def get_sidebar    
    @archive_posts = Post.live.limit(10)
    get_tags
  end
  
  def get_tags
    @tags = Post.tag_counts(:conditions => { :live => true }).order('count DESC').limit(50)
  end

end



#class PostsController < Spree::BaseController
#
#  helper :products
#
#  def index
#    @posts_by_month = Post.find(:all, :conditions => { :live => true }, :limit => 50, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
#    
#    scope = Post.includes(:images).order("posted_at DESC")
#    
#    if params[:year].present?
#      month = 1
#      day = 1  
#      if params[:month].present?
#        if params[:day].present?
#          day = params[:day].to_i
#        end
#        month = params[:month].to_i
#      end
#      date = Date.new(params[:year].to_i, month, day)
#    end
#    
#    
#    scope = scope.where("posted_at > ? AND posted_at <= ?", date, Time.now.at_beginning_of_day)
#    
#    #scope = scope.where("day(posted_at) = ?",   params[:day]) if params[:day].present?
#    #scope = scope.where("month(posted_at) = ?", params[:month]) if params[:month].present?
#    #scope = scope.where("year(posted_at) = ?",  params[:year]) if params[:year].present?
#    
#    @posts = scope.paginate(:page => params[:page])
#  end
#  
#  def show
#    @post = Post.find_by_path(params[:id])
#  end
#  
#  
#  def archive
#    @posts = Post.find(:all, :conditions => { :live => true }, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
#  end
#  
#end
#
#
##class PostsController < Spree::BaseController
##
##  def index
##    @posts = Post.live
##  end
##  
##  def show
##    @post = Post.find_by_path(params[:id])
##  end
##
##end