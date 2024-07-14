# template for dummy rails app used in specs

gem 'activeadmin_assets', path: __dir__ + '/../../'
gem 'activeadmin', '>= 4.0.0.beta7', '< 5.0.0'
gem 'csv'

# https://github.com/activeadmin/activeadmin/pull/7235#issuecomment-1000823435
insert_into_file 'config/environments/test.rb', 'false # ', after: /config.eager_load *=/

generate 'model', 'User first_name:string last_name:string admin:boolean --no-test-framework --no-timestamps'
generate 'active_admin:install --skip-users'

insert_into_file 'config/initializers/active_admin.rb', <<-RUBY, after: "|config|\n"
  config.load_paths = [File.join(Rails.root, 'app/lib/aa')]
RUBY

file 'app/lib/aa/users.rb', File.read(__dir__ + '/user_resource_template.rb')

file 'app/lib/aa/dashboard.rb', File.read(__dir__ + '/dashboard_template.rb')

route 'root "application#index"'

rake 'db:migrate db:test:prepare'
