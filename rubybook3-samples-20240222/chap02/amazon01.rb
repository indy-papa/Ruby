# frozen_string_literal: true

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.amazon.co.jp/' # <1>
