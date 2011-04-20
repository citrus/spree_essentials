class PagesController < ApplicationController
  
  before_filter :get_page, :only => :show
  
  def show
  
  
    puts @page.inspect
  
    if @page.root?
      @posts = Post.live.limit(5) if defined?(SpreeEssentialBlog)
      @articles = Article.live.limit(5) if defined?(SpreeEssentialNews)
      render :template => 'pages/home'
    end
  end
  
  private
  
    def get_page
      @page = Page.active.find_by_path(page_path)
    end
      
    def page_path
      params[:page_path] || "/"
    end
  
    def accurate_title
      @page.meta_title
    end
  
end