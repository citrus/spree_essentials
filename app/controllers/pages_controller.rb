class PagesController < Spree::BaseController
  
  def show
    @page = object
    if @page.root?
      @posts = Post.live.limit(5) if defined?(SpreeEssentialBlog)
      @articles = Article.live.limit(5) if defined?(SpreeEssentialNews)
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