Deface::Override.new(:virtual_path  => "spree/layouts/admin",
                     :name          => "spree_essential_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :partial       => "spree/admin/shared/contents_tab",
                     :disabled      => false)
