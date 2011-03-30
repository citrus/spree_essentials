require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    
  end
  
  should "get the homepage" do
    get :index
    assert_response :success
  end
    
end