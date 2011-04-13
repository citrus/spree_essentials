class PagesController < Spree::BaseController
  
  helper 'blog/posts'
  helper_method :object
  
  def show
    @page = object
    if @page.root?
      @posts = Post.live.limit(10)
      render :template => 'pages/home'
    end
  end
  
  private
  
    def object
      @object ||= Page.active.find_by_path(params[:page_path])
    end
  
    def accurate_title
      @page.meta_title
    end
  
end