class Spree::Admin::UploadsController < Spree::Admin::ResourceController
  
	def index
	  render :template => "spree/admin/uploads/#{request.xhr? ? 'picker' : 'index'}", :layout => !request.xhr?
  end
  
  private
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "created_at.desc"
      @search = Spree::Upload.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
