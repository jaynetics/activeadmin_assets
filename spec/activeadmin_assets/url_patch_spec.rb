describe ActiveAdminAssets::URLPatch do
  it 'applies to the active_admin stylesheet' do
    result = render { stylesheet_link_tag 'active_admin' }
    expect(result).to start_with('<link rel="stylesheet" href="/active_admin_assets/')
  end

  it 'does not apply to other stylesheets' do
    result = render { stylesheet_link_tag 'my_own_thing' }
    expect(result).not_to include('active_admin_assets')
  end

  it 'applies to the whole ActiveAdmin importmap' do
    result = render { javascript_importmap_tags 'active_admin', importmap: ActiveAdmin.importmap }
    paths = result.scan(%r{"(/[^"]+)"}).flatten.uniq
    expect(paths).not_to be_empty
    paths.each do |path|
      expect(path).to start_with('/active_admin_assets/')
    end
  end

  it 'does not apply to custom additions to the ActiveAdmin importmap' do
    ActiveAdmin.importmap.pin('my_own_thing')
    result = render { javascript_importmap_tags 'active_admin', importmap: ActiveAdmin.importmap }
    expect(result).to include('"my_own_thing": "/my_own_thing.js"')
    expect(result).to include('<link rel="modulepreload" href="/my_own_thing.js">')
  ensure
    ActiveAdmin.importmap.packages.delete('my_own_thing')
  end

  def render(&block)
    context = Class.new(ActionController::Base)
    context.helper(described_class)
    context.helpers.instance_exec(&block)
  end
end
