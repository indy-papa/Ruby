# frozen_string_literal: true

require 'selenium-webdriver'
require_relative './account_info'

class AmazonManipulator
  include AccountInfo

  BASE_URL = 'https://www.amazon.co.jp/' # <1>

  def initialize(account_file) # <2>
    @driver = Selenium::WebDriver.for :chrome # <3>
    @wait = Selenium::WebDriver::Wait.new(timeout: 20) # <4>
    @account = read(account_file) # <5>
  end

  def run
    @driver.get 'https://www.amazon.co.jp/'
    element = @driver.find_element(:id, 'nav-link-accountList')
    puts element.text
    element.click
    @wait.until { @driver.find_element(:id, 'ap_email').displayed? }
    element = @driver.find_element(:id, 'ap_email')
    element.send_keys(@account[:email])
    element = @driver.find_element(:id, 'continue')
    element.click
    @wait.until { @driver.find_element(:id, 'ap_password').displayed? }
    element = @driver.find_element(:id, 'ap_password')
    element.send_keys(@account[:password])
    element = @driver.find_element(:id, 'signInSubmit')
    element.click
    @wait.until { @driver.find_element(:id, 'nav-link-accountList').displayed? }
    sleep 3
    @driver.quit
  end
end

if __FILE__ == $PROGRAM_NAME
  abort 'account file not specified.' unless ARGV.size == 1 # <6>
  app = AmazonManipulator.new(ARGV[0]) # <7>
  app.run
end
