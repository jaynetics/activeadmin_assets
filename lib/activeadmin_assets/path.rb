require 'active_admin/version'

module ActiveAdminAssets
  # Add VERSIONs to invalidate browser caches on gem updates.
  def self.path
    "#{@path || '/active_admin_assets'}/#{ActiveAdmin::VERSION}/#{VERSION}/"
  end

  def self.path=(arg)
    @path = arg && !arg.empty? && "/#{arg.gsub(%r{\A/|/\z}, '')}"
  end
end
