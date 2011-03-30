#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class PostIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Post.destroy_all
    11.times{ |i| Factory.create(:post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) }
  end
  
  should "get the blog page" do
    visit posts_path
    # first post
    assert has_link?("Capy post 1")
    # last post
    assert has_link?("Capy post 9")
    # archive link
    assert has_link?("View Full Archive")
    # tag link
    assert has_link?("peanut butter")
    # page two
    assert has_link?("2")
    assert has_link?("Next →")
  end
  
  should "get a blog post" do
    @post = Post.first
    visit full_post_path(@post.year, @post.month, @post.day, @post)
    within('h1') do
      assert has_content?(@post.title)
    end
  end
  
  should "get the archive" do
    visit archive_posts_path
    assert has_link?("Capy post 1")
    assert has_link?("Shop the store")
  end
  
  should "get the archive" do
    visit archive_posts_path
    assert has_link?("Capy post 1")
    assert has_link?("Shop the Store")
  end
  
end
