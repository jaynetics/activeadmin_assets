# frozen_string_literal: true

describe ActiveAdminAssets, 'CSS' do
  let(:user) { User.create!(id: 1, first_name: 'Stable', last_name: 'String') }
  before { prevent_fluctuating_version_text }

  it 'has dashboard css' do
    visit admin_root_path
    expect_stable_screenshot('dashboard')
  end

  it 'has index css' do
    user # put in DB
    visit admin_users_path
    expect_stable_screenshot('resource_index')
  end

  it 'has show css' do
    visit admin_user_path(user)
    expect_stable_screenshot('resource_show')
  end

  it 'has form css' do
    visit edit_admin_user_path(user)
    expect_stable_screenshot('resource_form')
  end

  def expect_stable_screenshot(name)
    # standardize resolution / window size
    page.current_window.resize_to(1400, 600)

    # standardize light/dark mode
    $selenium_driver.browser.execute_cdp(
      "Emulation.setEmulatedMedia",
      features: [{ "name": "prefers-color-scheme", "value": "light" }],
    )

    sleep 0.1

    # run capybara-screenshot-diff
    screenshot(name)
  end

  def prevent_fluctuating_version_text
    allow(I18n).to receive(:t).and_wrap_original do |m, *args, **kw, &blk|
      args[0] == 'active_admin.powered_by' ? 'test' : m.call(*args, **kw, &blk)
    end
  end
end
