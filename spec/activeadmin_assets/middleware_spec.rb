describe ActiveAdminAssets::Middleware do
  it 'logs a warning when an asset is not found' do
    env = { Rack::PATH_INFO => "#{ActiveAdminAssets.path}/unknown" }
    app = ->* { [ 404, {}, 'nada'] }

    expect(Rails.logger).to receive(:warn)
    expect(described_class.new(app).call(env)).to eq [404, {}, 'nada']
  end
end
