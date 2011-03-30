require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  def setup
    Page.destroy_all
  end
  
  context "with a homepage" do
  
    setup do
      @page = Factory.create(:page, :title => "Home", :path => "/")
    end
    
    should "get a homepage" do
      get :show, :path => "/"
      assert_not_nil assigns(:page)
      assert_response :success
    end
    
  end
    
end