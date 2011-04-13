class Admin::Blog::PostProductsController < Admin::BaseController
  
  before_filter :load_data
  
  def create
    position = @post.products.count
    @product = Variant.find(params[:variant_id]).product
    PostProduct.create(:post_id => @post.id, :product_id => @product.id, :position => position)
    render :partial => "admin/blog/post_products/related_products_table", :locals => { :post => @post }, :layout => false 
  end
    
  def destroy
    @related = PostProduct.find(params[:id])
    if @related.destroy
      render_js_for_destroy
    end
  end
    
  private
  
    def load_data
	  	@post = Post.find_by_path(params[:post_id])
    end

end