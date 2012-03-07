require 'test_helper'

class Spree::Admin::SpreeEssentialsHelperTest < ActionView::TestCase
    
  setup do
    setup_with_controller
    visit "/admin"
  end
  
  def spree
    Spree::Core::Engine.routes.url_helpers
  end  
  
  def request
    @request
  end

  # not sure why setting the request_uri doesn't also update @fullpath
  def visit(path="/")
    @request.request_uri = path
    @request.instance_variable_set "@fullpath", path 
    @request
  end
  
  should "build admin contents tab" do
    assert_equal "<li><a href=\"/admin/uploads\">Content</a></li>", contents_tab
  end

  should "add selected class to admin contents tab" do
    visit "/admin/uploads"
    assert_equal "<li class=\"selected\"><a href=\"/admin/uploads\">Content</a></li>", contents_tab
  end
  
  should "have markdown helper link" do
    assert_equal "<em class=\"small markdown-helper\">Parsed With <a href=\"http://daringfireball.net/projects/markdown/basics\" onclick=\"window.open(this.href); return false\">Markdown</a></em>", markdown_helper
  end
    
end
