# frozen_string_literal: true

describe ActiveAdminAssets, 'CSS' do
  let(:user) { User.create!(id: 1, first_name: 'Stable', last_name: 'String') }

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

    # remove fluctuating version number at bottom of page
    expect(page).to have_content('Powered by')
    page.execute_script <<~JS
      var xpath = "//div[contains(text(), 'Powered by')]";
      var node = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      node.remove();
    JS
    expect(page).not_to have_content('Powered by')

    # run capybara-screenshot-diff
    screenshot(name)
  end
end
