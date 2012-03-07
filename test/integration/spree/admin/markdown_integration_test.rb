require "integration_test_helper"

class Spree::Admin::MarkdownIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    SpreeEssentials.register :example, SpreeEssentialExample
  end
  
  teardown do
    SpreeEssentials.essentials.clear
  end
  
  MARKDOWN = <<MD

### OMG

* item 1

**bold!** & _italic_

[just a link](http://example.com)

MD
  
  def assert_markdown_renders
    assert_seen "OMG",    :within => "h3"
    assert_seen "item 1", :within => "ul li"
    assert_seen "bold!",  :within => "strong"
    assert_seen "italic", :within => "em"
    assert has_link?("just a link", :href => "http://example.com")
  end
   
  should "render have markdown editor and render it's result" do
    visit spree.new_admin_example_path
    fill_in "Title", :with => "Just an example"
    fill_in "Body",  :with => MARKDOWN
    within ".markItUpHeader" do
      click_link "Preview"
    end    
    within_frame "markItUpPreviewFrame" do
      assert_markdown_renders
    end
    click_button "Create"
    assert_equal spree.admin_example_path(Spree::Example.last), current_path
    within ".markdown-result" do
      assert_markdown_renders
    end
  end
  
end
