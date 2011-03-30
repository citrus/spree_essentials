class PagesController < Spree::BaseController
  
  def show
    path = "/" + params[:path].to_s.sub(/^\/*/, '')
    @page = Page.active.find_by_path(path)
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