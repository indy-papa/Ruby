# frozen_string_literal: true

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.amazon.co.jp/'
element = driver.find_element(:id, 'nav-link-accountList') # <1>
puts element.text # <2>
driver.quit # <3>
