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
  
  
  context "unpublished posts" do
  
    setup do
      @tags = "totally not published"
      @date = DateTime.parse("2011/3/20 16:00")
      @post = Factory.create(:post, :posted_at => @date, :tag_list => @tags, :live => false)
    end
    
    should "not include post in index" do
      get :index
      assert !assigns(:posts).include?(@post)
    end
    
    should "not include post in day specific index" do
      get :index, :year => @post.year, :month => @post.month, :day => @post.day
      assert !assigns(:posts).include?(@post)
    end
    
    should "not include post in month specific index" do
      get :index, :year => @post.year, :month => @post.month
      assert !assigns(:posts).include?(@post)
    end
    
    should "not include post in year specific index" do
      get :index, :year => @post.year
      assert !assigns(:posts).include?(@post)
    end
    
    should "not include post in search results" do
      get :search, :query => @tags
      assert !assigns(:posts).include?(@post)
    end
    
  end
  
  
  context "published posts" do
  
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