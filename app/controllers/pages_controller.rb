class PagesController < Spree::BaseController
  
  helper_method :object
  
  def show
    @page = object
  end
  
  private
  
    def object
      @object ||= Page.active.find_by_path(params[:path])
    end
  
    def accurate_title
      @page.meta_title
    end
  
end