class Spree::Admin::UploadsController < Spree::Admin::ResourceController

	def index
	  render :template => "spree/admin/uploads/#{request.xhr? ? 'picker' : 'index'}", :layout => !request.xhr?
  end

  private

    def collection
      params[:q] ||= {}
      params[:q][:sorts] ||= "attachment_updated_at desc"
      @search = Spree::Upload.search(params[:q])
      if request.xhr?
        @collection = @search.result
      else
        @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
      end
    end

end
