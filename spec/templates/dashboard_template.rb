ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: 'foo'

  content title: 'bar' do
    panel('baz') { 'qux' }
  end
end
