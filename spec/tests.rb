require 'rails_helper'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'watir-webdriver'
# 
# Selenium::WebDriver::Chrome.driver_path = "/usr/local/share/chromedriver"
#
# Capybara.register_driver :chrome do |app|
#   # optional
#   client = Selenium::WebDriver::Remote::Http::Default.new
#   # optional
#   client.timeout = 10
#   Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client,:use_sudo=>true)
# end
#
# Capybara.javascript_driver = :chrome

describe "the signin process", :type => :feature ,js: true do
  it "signs me in" do
    visit '/influencers'
    within("#session") do
      fill_in 'Email', with: 'apoorv@sp-assurance.com'
      fill_in 'Password', with: 'lion1310'
    end
    click_button 'Log in'
    expect(page).to have_content 'Success'
  end
end
