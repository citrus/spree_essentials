class Admin::Blog::PostImagesController < Admin::ResourceController
  
  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  def update_positions
    params[:positions].each do |id, index|
      PostImage.update_all(['position=?', index], ['id=?', id])
    end

    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end
  
  private
  
  def location_after_save
    admin_post_images_url(@post)
  end

  def load_data
    @post = Post.find_by_path(params[:post_id])
  end

  def set_viewable
    @post_image.viewable = @post
  end

  def destroy_before
    @viewable = @post_image.viewable
  end

end