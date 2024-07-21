require 'fileutils'

out_dir = "#{__dir__}/../lib/activeadmin_assets/assets"

desc 'Build all ActiveAdmin assets'
task :build_assets => %i[clear css js]

desc 'Clear all ActiveAdmin assets'
task :clear do
  FileUtils.rm_rf(out_dir)
end

desc 'Build ActiveAdmin stylesheets'
task :css do
  dest = "#{out_dir}/active_admin.css"

  sh "#{__dir__}/../bin/tailwindcss",
     '-c', "#{__dir__}/css/tailwind.config.js",
     '-i', "#{__dir__}/css/entrypoint.css",
     '-o', dest

  # keep non-gzipped version for optional use in asset pipelines
  sh 'gzip', '-fk', dest
end

# In theory, we could simply use the JS files included in the activeadmin gem
# and serve them, but adding them to activeadmin_assets allows us to treat JS
# the same as CSS, making for a simpler URLPatch and Middleware.
desc 'Copy ActiveAdmin javascript'
task :js do
  active_admin_path = `bundle show activeadmin`.chomp
  Dir["#{active_admin_path}/{app,vendor}/javascript/**/*.js"].each do |file|
    relative_path = file.split(%r{(?:app|vendor)/javascript/}).last
    dest = "#{out_dir}/#{relative_path}"
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.cp(file, dest)
    sh 'gzip', '-f', dest
  end
end
