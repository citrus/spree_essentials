class Admin::Blog::PostsController < Admin::ResourceController
  
  #resource_controller

  #create.response do |wants|
  #  wants.html { redirect_to object_url }
  #end
  #
  #update.response do |wants|
  #  wants.html { redirect_to object_url }
  #end

  #destroy.success.wants.js { render_js_for_destroy }

  private
  
    
    def find_resource
	  	@object ||= Post.find_by_path(params[:id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "posted_at.desc"
      @search = Post.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end