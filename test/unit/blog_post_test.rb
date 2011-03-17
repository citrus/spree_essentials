require 'test_helper'

module Blog

  class PostTest < Test::Unit::TestCase

    def setup
      Post.destroy_all
    end
    
    subject { Post.new }
    
    should validate_presence_of(:title)
    should validate_presence_of(:path)
    should validate_presence_of(:posted_at)
    should validate_presence_of(:body)
    
  end
  
end