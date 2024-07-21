require 'selenium/webdriver'

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :customized_chrome do |app|
  version = Capybara::Selenium::Driver.load_selenium
  options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
  options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.add_argument('--headless')
    # prevent different screenshot resolution on retina devices
    opts.add_argument('--force-device-scale-factor=1')
    # various fixes for GH actions
    opts.add_argument('--disable-dev-shm-usage')
    opts.add_argument('--disable-extensions')
    opts.add_argument('--disable-site-isolation-trials')
    opts.add_argument('--remote-debugging-pipe')
  end
  $selenium_driver = Capybara::Selenium::Driver.new(app, **{ browser: :chrome, options_key => options })
end

Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.save_path = File.expand_path('../screenshots', __dir__)
Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.fail_if_new = ENV['CI']
Capybara::Screenshot::Diff.tolerance = 0.01

RSpec.configure do |config|
  config.before(:each, type: :system) { driven_by :customized_chrome }
  config.include ::CapybaraScreenshotDiff::DSL
end
