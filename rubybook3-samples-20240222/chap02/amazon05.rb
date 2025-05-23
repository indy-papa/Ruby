# frozen_string_literal: true

require 'selenium-webdriver'
require_relative './account_reader'

abort 'account file not specified.' unless ARGV.size == 1
account = read_account(ARGV[0])

driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(timeout: 20)

driver.get 'https://www.amazon.co.jp/'
element = driver.find_element(:id, 'nav-link-accountList')
puts element.text
element.click
wait.until { driver.find_element(:id, 'ap_email').displayed? }
element = driver.find_element(:id, 'ap_email')
element.send_keys(account[:email])
element = driver.find_element(:id, 'continue')
element.click
wait.until { driver.find_element(:id, 'ap_password').displayed? }
element = driver.find_element(:id, 'ap_password') # <1>
element.send_keys(account[:password]) # <2>
element = driver.find_element(:id, 'signInSubmit') # <3>
element.click # <4>
wait.until { driver.find_element(:id, 'nav-link-accountList').displayed? } # <5>
sleep 3
driver.quit
