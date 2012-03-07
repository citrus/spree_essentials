class Spree::Admin::MarkdownController < Spree::Admin::BaseController

  def preview
    render :text => RDiscount.new(params[:data].to_s).to_html
  end 

end
