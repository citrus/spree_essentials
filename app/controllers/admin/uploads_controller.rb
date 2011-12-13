class Admin::UploadsController < Admin::ResourceController
  
	def index
	  render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr?
  end
  
  private
  
    def translated_object_name
      I18n.t("upload.model_name")
    end
   
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "created_at.desc"
      @search = Upload.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
