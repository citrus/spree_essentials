require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    Post.destroy_all
  end
  
  should "get the blog index" do
    get :index
    assert_not_nil assigns(:posts)
    assert_not_nil assigns(:posts_by_month)
    assert_response :success
  end
  
  context "with an existing post" do
  
    setup do
      @post = Factory.create(:post, :tag_list => "gruyere, emmentaler, fondue")
    end
  
    should "find by seo path" do
      get :show, :year => @post.year, :month => @post.month, :day => @post.day, :id => @post.to_param
      assert_not_nil assigns(:post)
      assert_response :success
    end
    
    should "not find by tags" do
      get :search, :query => "some crazy random query"
      assert_equal 0, assigns(:posts).length
      assert_response :success
    end
    
    should "find by tags" do
      get :search, :query => "gruyere"
      assert_equal 1, assigns(:posts).length
      assert_equal @post, assigns(:posts).first
      assert_response :success
    end
  
  end
  
  context "some existing posts" do
  
    setup do
      @date = DateTime.parse("2011/3/20 16:00")
      @post = Factory.create(:post, :posted_at => @date)
      10.times {|i| Factory.create(:post, :title => "Today's Sample Post #{i}",      :posted_at => @date) }
      10.times {|i| Factory.create(:post, :title => "Last Weeks's Sample Post #{i}", :posted_at => @date - 1.week) }
      10.times {|i| Factory.create(:post, :title => "Last Month's Sample Post #{i}", :posted_at => @date - 1.month) }
      10.times {|i| Factory.create(:post, :title => "Last Years's Sample Post #{i}", :posted_at => @date - 1.year) }
    end
  
    should "assert proper post count" do
      assert_equal 41, Post.count
    end
  
    should "paginate posts by day" do
      get :index, :year => @post.year, :month => @post.month, :day => @post.day
      assert_equal 10, assigns(:posts).length
      assert_equal 11, assigns(:posts).total_entries
      assert_equal 2,  assigns(:posts).total_pages
      assert_response :success
    end
    
    should "get posts by month" do
      get :index, :year => @post.year, :month => @post.month
      assert_equal 10, assigns(:posts).length
      assert_equal 21, assigns(:posts).total_entries
      assert_equal 3,  assigns(:posts).total_pages
      assert_response :success
    end
    
    should "get posts by year" do
      get :index, :year => @post.year
      assert_not_nil assigns(:posts)
      assert_equal 10, assigns(:posts).length
      assert_equal 31, assigns(:posts).total_entries
      assert_equal 4,  assigns(:posts).total_pages
      assert_response :success
    end
  
  end
    
end