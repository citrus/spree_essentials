Spree::BaseHelper.class_eval do
   
  def markdown_helper
    content_tag('em', :class => 'small') do
      [ 
       "&nbsp;",
        t('essentials.parsed_with'),
        link_to("Markdown", "http://daringfireball.net/projects/markdown/basics", :onclick => 'window.open(this.href); return false')
      ].join(" ").html_safe
    end
  end
      
  def method_missing(method, *args, &block)
    return super unless method.to_s =~ /_path$/
    "/" + method.to_s.sub(/_path$/, '').gsub('_', '-')
  end
      
end