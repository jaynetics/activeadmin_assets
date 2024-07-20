desc 'Run benchmarks'
task :benchmark do
  require 'benchmark/ips'
  require 'activeadmin_assets'
  require 'action_dispatch'

  puts 'How much does the ActiveAdminAssets::Middleware slow down '\
       'non-asset requests compared to ActionDispatch::Static?'

  app = ->(_) {}
  env = { "PATH_INFO" => "/index.html", "REQUEST_METHOD" => "GET" }
  m1 = ActiveAdminAssets::Middleware.new(app)
  m2 = ActionDispatch::Static.new(app, 'some_path')

  Benchmark.ips do |x|
    x.report('ActiveAdminAssets::Middleware') { m1.call(env) }
    x.report('ActionDispatch::Static') { m2.call(env) }
    x.compare!
  end
  # => ActiveAdminAssets::Middleware:  4072263.3 i/s
  # => ActionDispatch::Static:   155206.9 i/s - 26.24x  slower
end
