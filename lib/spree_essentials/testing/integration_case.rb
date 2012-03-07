require "capybara/rails"
require "selenium/webdriver"

class SpreeEssentials::IntegrationCase < ActiveSupport::TestCase

  include Capybara::DSL
    
  Capybara.default_driver   = :selenium
  Capybara.default_selector = :css

  self.use_transactional_fixtures = false

  # Checks for missing translations after each test
  teardown do
    unless source.blank?
      matches = source.match(/translation[\s-]+missing[^"]*/) || []
      assert_equal 0, matches.length, "** #{matches[0]}"
    end
  end
  
  # By defining this we don't need to depend on spree, just spree_core since the
  # included url helper lives in the spree root
  def spree
    Spree::Core::Engine.routes.url_helpers
  end
  
  # An assertion for ensuring content has made it to the page.
  #    
  #    assert_seen "Site Title"
  #    assert_seen "Peanut Butter Jelly Time", :within => ".post-title h1"
  #      
  def assert_seen(text, opts={})
    msg = "Should see `#{text}`"
    if opts[:within]
      within(opts[:within]) do
        assert has_content?(text), msg + " within #{opts[:within]}"
      end
    else
      assert has_content?(text), msg
    end
  end
  
  # Asserts the proper flash message
  #    
  #    assert_flash :notice, "Post was successfully saved!"
  #    assert_flash :error, "Oh No, bad things happened!"
  #
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end
  
  # Asserts the proper browser title
  #    
  #    assert_title "My Site - Is super cool"
  #
  def assert_title(title)
    assert_seen title, :within => "head title"
  end
  
  # Asserts meta tags have proper content
  #    
  #    assert_meta :description, "So let me tell you about this one time..."
  #    assert_meta :keywords, "seo, is, fun, jk."
  #
  def assert_meta(tag, text)
    tag = find(:xpath, "//head/meta[@name='#{tag.to_s}']")
    assert_equal text, tag.native.attribute("content")
  end
      
end
