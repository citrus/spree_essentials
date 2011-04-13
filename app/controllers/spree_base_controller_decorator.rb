Spree::BaseController.class_eval do
  
  before_filter :get_pages
  
  helper_method :contents_for
  
  def get_pages
    @page = Page.find_by_path(request.path) rescue nil
    scope = request.path =~ /^\/admin/ ? Page.scoped : Page.visible
    @pages = scope.order(:position).all
  end

  def contents_for(path)
    page = Page.find_by_path(path)
    page ? page.contents : []
  end
  
  def for_context(context)
    return [] unless @page
    @page.contents.select{ |c| c.context == context }
  end

end