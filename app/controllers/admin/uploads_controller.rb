class Admin::UploadsController < Admin::BaseController
  
  resource_controller

	index.response do |wants|
		wants.html { render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr? }
  end
  
  new_action.response do |wants|
    wants.html { 
      render :action => :new, :layout => false
    }
  end

	create.response do |wants|
		wants.html {redirect_to admin_uploads_path}
  end
  
  update.response do |wants|
    wants.html { redirect_to collection_url }
  end
  
  destroy.success.wants.js { render_js_for_destroy }

  private
        
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "posted_at.desc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end