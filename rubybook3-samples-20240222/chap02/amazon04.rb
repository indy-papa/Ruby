# frozen_string_literal: true

require 'selenium-webdriver'
require_relative './account_reader' # <1>

abort 'account file not specified.' unless ARGV.size == 1 # <2>
account = read_account(ARGV[0]) # <3>

driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.amazon.co.jp/'
element = driver.find_element(:id, 'nav-link-accountList')
puts element.text
element.click
element = driver.find_element(:id, 'ap_email') # <4>
element.send_keys(account[:email]) # <5>
element = driver.find_element(:id, 'continue') # <6>
element.click # <7>
sleep 3
driver.quit
