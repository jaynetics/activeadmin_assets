desc 'Build Active Admin stylesheets'
task :css do
  dest = "#{__dir__}/../lib/activeadmin_assets/assets/active_admin.css"

  sh 'npx',
     '-y',
     '@tailwindcss/cli',
     '-i', "#{__dir__}/css/entrypoint.css",
     '--minify',
     '-o', dest

  sh 'gzip', '-f', dest
end
