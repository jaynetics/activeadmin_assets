# frozen_string_literal: true

describe ActiveAdminAssets, 'JS' do
  it 'has confirm dialog js (ujs)', type: :system do
    user = User.create!
    visit admin_user_path(user)

    js_alert_text = accept_confirm { click_link 'Delete User' }
    sleep 0.1 # wait for delayed delete request

    expect(js_alert_text).to include('Are you sure')
    expect(User.count).to eq(0)
  end

  it 'has menu js (flowbite)' do
    visit admin_root_path

    # use mobile size so sidebar menu is initially hidden
    page.current_window.resize_to(400, 600)
    expect(page).not_to have_text('Stuff')

    # toggle sidebar menu (this uses flowbite JS)
    find('[data-drawer-target="main-menu"]').click
    expect(page).to have_text('Stuff')

    # expand nested menu (this is custom AA JS - features/main_menu.js)
    expect(page).not_to have_text('Useroos')
    click_on 'Stuff'
    expect(page).to have_text('Useroos')
  end
end
