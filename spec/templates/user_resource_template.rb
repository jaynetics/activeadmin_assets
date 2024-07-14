ActiveAdmin.register User do
  menu label: 'Useroos', parent: 'Stuff'
  actions :all
  config.filters = false
end
