ActiveAdmin.register User do
  menu label: 'Useroos', parent: 'Stuff'
  actions :all
  config.filters = false

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :admin
    end
    f.actions
  end
end
