class Admin::PostImagesController < Admin::BaseController
  
  resource_controller
  
  before_filter :load_data
	
	new_action.response do |wants|
    wants.html { 
      render :action => :new, :layout => false
    }
  end

	create.response do |wants|
		wants.html {redirect_to admin_post_images_url(@post)}
  end

	update.response do |wants|
		wants.html {redirect_to admin_post_images_url(@post)}
  end
	
	create.before :create_before
	update.before :update_before
	destroy.before :destroy_before
  
  destroy.response do |wants| 
    wants.html do
			render :text => ""
    end
  end
 
  private


  def load_data
		@post = Post.find_by_path(params[:post_id])
  end

  def create_before
	  set_default
	end
	
	def update_before
	  set_default
  end
  
  def set_default
    object.type = 'PostImage'
	  object.viewable_type = 'Post'
		object.viewable_id = @post.id
  end
  
  def destroy_before 
    @viewable = object.viewable
  end

end
