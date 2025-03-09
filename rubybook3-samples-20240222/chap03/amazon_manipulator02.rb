# frozen_string_literal: true

require 'selenium-webdriver'
require_relative './account_info'

class AmazonManipulator
  include AccountInfo

  BASE_URL = 'https://www.amazon.co.jp/'

  def initialize(account_file)
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 20)
    @account = read(account_file)
  end

  def login # <1>
    @driver.get BASE_URL
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
  end

  def logout # <2>
    @wait.until { @driver.find_element(:id, 'nav-link-accountList').displayed? }
    element = @driver.find_element(:id, 'nav-link-accountList')
    @driver.action.move_to(element).perform # <3>
    @wait.until { @driver.find_element(:id, 'nav-item-signout').displayed? }
    element = @driver.find_element(:id, 'nav-item-signout') # <4>
    element.click # <5>
    @wait.until { @driver.find_element(:id, 'ap_email').displayed? } # <6>
  end

  def run # <7>
    login
    sleep 3 # <8>
    logout
    sleep 3 # <9>
    @driver.quit # <10>
  end
end

if __FILE__ == $PROGRAM_NAME
  abort 'account file not specified.' unless ARGV.size == 1
  app = AmazonManipulator.new(ARGV[0])
  app.run
end
