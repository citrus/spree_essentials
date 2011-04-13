#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class AdminPostIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Post.destroy_all
    11.times{ |i| Factory.create(:post, :title => "Capy post #{i}", :posted_at => Time.now - i.days) }
  end
  
  should "get the blog index" do
    visit admin_posts_path
  end
    
end
