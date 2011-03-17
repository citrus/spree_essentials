class Admin::MarkdownController < Admin::BaseController

  def preview
    render :text => RDiscount.new(params[:data].to_s).to_html
  end 

end