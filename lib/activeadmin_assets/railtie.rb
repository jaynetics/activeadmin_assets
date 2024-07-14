require 'rails/railtie'
require 'rails/engine/railties'

module ActiveAdminAssets
  class Railtie < ::Rails::Railtie
    initializer 'activeadmin_assets.initializer' do |app|
      ActiveAdminAssets::CompatibilityCheck.call(app)
      app.middleware.insert(0, ActiveAdminAssets::Middleware)
    end

    ActiveSupport.on_load(:active_admin_controller) do
      ActiveAdmin::LayoutHelper.prepend(ActiveAdminAssets::URLPatch)
    end
  end
end
