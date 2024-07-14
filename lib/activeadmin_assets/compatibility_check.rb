module ActiveAdminAssets
  # Checks if custom/manual asset provisioning is in place.
  # To be more thorough, this could also check for usage of new tailwind classes
  # in any admin controllers or partials, though that might be a bit expensive.
  module CompatibilityCheck
    def self.call(app)
      return unless %w[development test].include?(ENV['RAILS_ENV'])

      customizations = Dir[app.root.join('app/assets/{builds,stylesheets}/active_admin.*')]
      customizations.any? and warn ""\
        "The activeadmin_assets gem is not compatible with providing core "\
        "activeadmin assets yourself. Please remove either the gem "\
        "or your custom files: #{customizations}"
    end
  end
end
