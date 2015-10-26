Deface::Override.new(:virtual_path  => 'spree/admin/shared/sub_menu/_configuration',
                     :name          => 'add_redirect_rules_admin_menu_link',
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{
                       <%= configurations_sidebar_menu_item 'Redirect Rules', admin_redirect_rules_path %>
                     })

