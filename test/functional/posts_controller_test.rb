require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    @post = Factory.create(:post)
  end
  
  should "get the blog index" do
    get :index
    assert_not_nil assigns(:posts)
    assert_not_nil assigns(:posts_by_month)
    assert_response :success
  end
  
  should "show the blog post" do
    get :show, :year => @post.year, :month => @post.month, :day => @post.day, :id => @post.to_param
    assert_not_nil assigns(:post)
    assert_response :success
  end
  
  context "some existing posts" do
  
    setup do
      Post.destroy_all
      @post = Factory.create(:post)
      10.times {|i| Factory.create(:post, :title => "Today's Sample Post #{i}", :posted_at => Time.now) }
      10.times {|i| Factory.create(:post, :title => "Last Weeks's Sample Post #{i}", :posted_at => Time.now - 1.week) }
      10.times {|i| Factory.create(:post, :title => "Last Month's Sample Post #{i}", :posted_at => Time.now - 1.month) }
      10.times {|i| Factory.create(:post, :title => "Last Years's Sample Post #{i}", :posted_at => Time.now - 1.year) }
    end
  
    should "have proper post count" do
      assert_equal 41, Post.count
    end
  
    should "get posts by day" do
      get :show, :year => @post.year, :month => @post.month, :day => @post.day
      assert_not_nil assigns(:posts)
      assert_response :success
    end
    
    should "get posts by month" do
      get :show, :year => @post.year, :month => @post.month
      assert_not_nil assigns(:posts)
      assert_response :success
    end
    
    should "get posts by year" do
      get :show, :year => @post.year
      assert_not_nil assigns(:posts)
      assert_response :success
    end
  
  end
    
end