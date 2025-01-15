# frozen_string_literral: true

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.amazon.co.jp'
