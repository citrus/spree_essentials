module Spree::Admin::SpreeEssentialsHelper
  
  def contents_tab
    routes = SpreeEssentials.essentials.map do |key, cls|
      route = cls.tab[:route] || "spree.admin_#{key}"
      send("admin.#{route}_path") rescue "##{key}"
    end
    routes.push spree.admin_uploads_path
    cls = request.fullpath.scan(Regexp.new(routes.join("|"))).empty? ? nil : 'selected'
    content_tag :li, :class => cls do
      link_to I18n.t('spree.admin.shared.contents_tab.content'), routes.first
    end
  end
  
  def markdown_helper
    content_tag('em', :class => 'small') do
      [ 
       "&nbsp;",
        t('essentials.parsed_with'),
        link_to("Markdown", "http://daringfireball.net/projects/markdown/basics", :onclick => 'window.open(this.href); return false')
      ].join(" ").html_safe
    end
  end
  
end
