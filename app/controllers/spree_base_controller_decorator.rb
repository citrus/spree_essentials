Spree::BaseController.class_eval do
  
  before_filter :get_pages
  
  def get_pages
    @pages = Page.visible.order(:position).all
  end

end