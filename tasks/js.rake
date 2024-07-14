require 'fileutils'

# In theory, we could simply use the JS files included in the activeadmin gem
# and serve them, but adding them to activeadmin_assets allows us to treat JS
# the same as CSS, making for a simpler URLPatch and Middleware.
desc 'Copy Active Admin javascript'
task :js do
  active_admin_path = `bundle show activeadmin`.chomp
  Dir["#{active_admin_path}/{app,vendor}/javascript/**/*.js"].each do |file|
    relative_path = file.split(%r{(?:app|vendor)/javascript/}).last
    dest = "#{__dir__}/../lib/activeadmin_assets/assets/#{relative_path}"
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.cp(file, dest)
    sh 'gzip', '-f', dest
  end
end
