desc 'Build Active Admin stylesheets'
task :css do
  dest = "#{__dir__}/../lib/activeadmin_assets/assets/active_admin.css"

  sh "#{__dir__}/../bin/tailwindcss",
     '-c', "#{__dir__}/css/tailwind.config.js",
     '-i', "#{__dir__}/css/entrypoint.css",
     '-o', dest

  sh 'gzip', '-f', dest
end
