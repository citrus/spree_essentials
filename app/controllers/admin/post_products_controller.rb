class Admin::PostProductsController < Admin::BaseController
  
  before_filter :load_data
  
  def create
    position = @post.products.count
    
    @product = Variant.find(params[:variant_id]).product
    
    @related = PostProduct.create(:post_id => @post.id, :product_id => @product.id, :position => position)
    puts @related.inspect
    render :partial => "admin/post_products/related_products_table", :locals => { :post => @post }, :layout => false 
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