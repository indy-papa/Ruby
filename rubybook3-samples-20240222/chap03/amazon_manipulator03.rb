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
    open_top_page
    open_login_page
    enter_mail_address
    enter_password
    wait_for_logged_in
  end

  def logout # <2>
    open_nav_link_popup
    wait_for_logged_out
  end

  def run # <3>
    login
    sleep 3
    logout
    sleep 3
    @driver.quit
  end

  private # <4>

  def wait_and_find_element(how, what) # <5>
    @wait.until { @driver.find_element(how, what).displayed? }
    @driver.find_element(how, what)
  end

  def open_top_page # <6>
    @driver.get BASE_URL
    wait_and_find_element(:id, 'navFooter')
  end

  def open_login_page # <7>
    element = wait_and_find_element(:id, 'nav-link-accountList')
    element.click
  end

  def enter_mail_address # <8>
    element = wait_and_find_element(:id, 'ap_email')
    element.send_keys(@account[:email])
    @driver.find_element(:id, 'continue').click
  end

  def enter_password # <9>
    element = wait_and_find_element(:id, 'ap_password')
    element.send_keys(@account[:password])
    @driver.find_element(:id, 'signInSubmit').click
  end

  def wait_for_logged_in # <10>
    wait_and_find_element(:id, 'nav-link-accountList')
  end

  def open_nav_link_popup # <11>
    element = wait_and_find_element(:id, 'nav-link-accountList')
    @driver.action.move_to(element).perform
  end

  def wait_for_logged_out # <12>
    element = wait_and_find_element(:id, 'nav-item-signout')
    element.click
    wait_and_find_element(:id, 'ap_email')
  end
end

if __FILE__ == $PROGRAM_NAME
  abort 'account file not specified.' unless ARGV.size == 1
  app = AmazonManipulator.new(ARGV[0])
  app.run
end
