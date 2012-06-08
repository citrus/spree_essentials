class Spree::Admin::UploadsController < Spree::Admin::ResourceController
  
	def index
	  if request.xhr?
	    @uploads = Spree::Upload.all
	  end
	  render :template => "spree/admin/uploads/#{request.xhr? ? 'picker' : 'index'}", :layout => !request.xhr?
  	end
  
  private
  
    def collection
      params[:q] ||= {}
      params[:q][:sort] ||= "created_at.desc"
      @search = Spree::Upload.search(params[:q])
      @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
