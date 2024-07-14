describe ActiveAdminAssets, '.path' do
  before do
    stub_const('ActiveAdmin::VERSION', 'v1')
    stub_const('ActiveAdminAssets::VERSION', 'v2')
  end

  it 'includes version numbers' do
    expect(ActiveAdminAssets.path).to eq('/active_admin_assets/v1/v2/')
  end

  it 'can be changed, keeping the format and version numbers' do
    {
      'a'     => '/a/v1/v2/',
      '/b'    => '/b/v1/v2/',
      'c/'    => '/c/v1/v2/',
      '/d/'   => '/d/v1/v2/',
      'e/f'   => '/e/f/v1/v2/',
      '/g/h'  => '/g/h/v1/v2/',
      '/i/j/' => '/i/j/v1/v2/',
      ''      => '/active_admin_assets/v1/v2/',
      nil     => '/active_admin_assets/v1/v2/',
    }.each do |setting, expected_result|
      ActiveAdminAssets.path = setting
      expect(ActiveAdminAssets.path).to eq(expected_result)
    end
  end
end
