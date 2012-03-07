class Spree::Admin::ExamplesController < Spree::Admin::ResourceController  

  # Quick hax to solve this bug in the spree_core

  #   ArgumentError in Spree/admin/examples#show
  #   
  #   Showing /Users/Spencer/.rbenv/versions/1.9.3-p125/lib/ruby/gems/1.9.1/gems/spree_core-1.0.1/app/views/spree/admin/shared/_show_resource_links.html.erb where line #2 raised:
  #   
  #   wrong number of arguments (0 for 1)
  #   Extracted source (around line #2):
  #   
  #   1: <p class="actions" data-hook="actions">
  #   2: <%= link_to t(:edit), edit_object_url %> |  <- the culprit!
  #   3: <%= link_to t(:back), collection_url %> |
  #   4: <%= link_to t(:delete), object_url, :confirm => t(:are_you_sure_you_want_to_delete_this_record), :method => :delete %>  |  <- also this translation is missing
  #   5: </p>
     
  def edit_object_url(optional_resource=nil)
    super @example
  end
  
  def location_after_save
    admin_example_path(@example)
  end
  
end
