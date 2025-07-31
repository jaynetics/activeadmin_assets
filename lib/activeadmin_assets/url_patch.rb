module ActiveAdminAssets
  # Modify asset URLs for active admins assets:
  # - prepend special path (includes VERSIONs to bust caches on gem updates)
  # - prevent sprockets, propshaft, importmap-rails from adding digests/checksums
  # ActiveAdmin updates change asset checksums even if contents remain unchanged.
  module URLPatch
    def stylesheet_link_tag(path, ...)
      return super unless active_admin_asset?(path)

      tag.link(rel: :stylesheet, href: path_to_asset("#{path.chomp('.css')}.css"))
    end

    # this is called by importmap-rails, too
    def path_to_asset(path, ...)
      return super unless active_admin_asset?(path)

      path.sub(%r{\A/?}, ActiveAdminAssets.path)
    end

    def active_admin_asset?(path)
      %r{\A/?(?:active_admin|flowbite|rails_ujs_esm)(?:[/.]|\z)}.match?(path)
    end

    def javascript_importmap_tags(...)
      own = ActiveAdminAssets.path
      super
        .gsub(/"integrity":\s*\{\K[^}]+"/) { |m| m.split(',').grep_v(/#{own}/).join(',') }
        .gsub(/href=('|")#{own}[^>]*\Kintegrity=\1(?~\1)\1/, '') # preload links
        .html_safe
    end
  end
end
