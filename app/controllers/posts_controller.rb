class PostsController < Spree::BaseController

  helper :products

  def index
    @posts_by_month = Post.find(:all, :conditions => { :live => true }, :limit => 50, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
    
    scope = Post.includes(:images).order("posted_at DESC")
    
    if params[:year].present?
      month = 1
      day = 1  
      if params[:month].present?
        if params[:day].present?
          day = params[:day].to_i
        end
        month = params[:month].to_i
      end
      date = Date.new(params[:year].to_i, month, day)
    end
    
    
    puts date.inspect
    
    
    scope = scope.where("posted_at > ? AND posted_at <= ?", date, Time.now.at_beginning_of_day)
    
    #scope = scope.where("day(posted_at) = ?",   params[:day]) if params[:day].present?
    #scope = scope.where("month(posted_at) = ?", params[:month]) if params[:month].present?
    #scope = scope.where("year(posted_at) = ?",  params[:year]) if params[:year].present?
    
    @posts = scope.paginate(:page => params[:page])
  end
  
  def show
    @post = Post.find_by_path(params[:id])
  end
  
  
  def archive
    @posts = Post.find(:all, :conditions => { :live => true }, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
  end
  
end


#class PostsController < Spree::BaseController
#
#  def index
#    @posts = Post.live
#  end
#  
#  def show
#    @post = Post.find_by_path(params[:id])
#  end
#
#end