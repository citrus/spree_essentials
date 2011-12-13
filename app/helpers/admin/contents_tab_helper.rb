module Admin::ContentsTabHelper
  
  def contents_tab
    routes = SpreeEssentials.essentials.map do |key, cls|
      route = cls.tab[:route] || "admin_#{key}"
      send("#{route}_path") rescue "##{key}"
    end
    routes.push admin_uploads_path
    cls = routes.include?(request.path) ? 'selected' : nil
    content_tag :li, :class => cls do
      link_to I18n.t('admin.shared.contents_tab.content'), routes.first
    end
  end
  
end
