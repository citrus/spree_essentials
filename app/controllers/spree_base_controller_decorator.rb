puts "HELLO" 

Spree::BaseController.class_eval do
  
  before_filter :get_pages
  
  def get_pages
    puts "*" * 88
    @pages = Page.visible.order(:position).all
  end


end