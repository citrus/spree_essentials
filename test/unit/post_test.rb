require 'test_helper'

class PostTest < Test::Unit::TestCase

  def setup
    Post.destroy_all
  end
  
  subject { Post.new }
  
  should validate_presence_of(:title)
  should validate_presence_of(:body)
  
  
  should "automatically set path" do
    @post = Factory.create(:post)
    puts @post.inspect
  end
  
  should "validate date time" do
    @post = Factory.stub(:post)
    @post.posted_at = "testing"
    assert !@post.valid?
  end
  
end