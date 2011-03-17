class PostsController < Spree::BaseController

  def index
    @posts_by_month = Post.find(:all, :conditions => { :live => true }, :limit => 50, :order => 'posted_at DESC').group_by { |post| post.posted_at.strftime("%B %Y") }
    @posts = Post.paginate(:all, :include => :images, :page => params[:page], :order => 'posted_at DESC')
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