desc 'Generate a dummy rails app for testing'
task :generate_spec_app do
  sh 'rm -rf spec/dummy'
  sh *%w[
    rails new spec/dummy
    --template=spec/templates/app_template.rb
    --skip-action-cable
    --skip-action-mailbox
    --skip-action-text
    --skip-active-job
    --skip-active-storage
    --skip-asset-pipeline
    --skip-bootsnap
    --skip-bundle
    --skip-dev-gems
    --skip-docker
    --skip-git
    --skip-hotwire
    --skip-javascript
    --skip-jbuilder
    --skip-keeps
    --skip-listen
    --skip-spring
    --skip-system-test
    --skip-test
    --skip-turbolinks
    --skip-webpack
  ]
end
