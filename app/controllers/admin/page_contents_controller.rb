class Admin::PageContentsController < Admin::BaseController

  resource_controller 
  belongs_to :page

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  destroy.success.wants.js { render_js_for_destroy }

  private
    
    def parent_object
	  	@page ||= Page.find_by_path(params[:page_id])
    end
    
    
    def object_name
      'content'
    end
        
    def model_name
      'Content'
    end
    
    def route_name
      'content'
    end
    
    def parent_association
      @page.contents
    end
      
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "page.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end