# frozen_string_literal: true

require 'selenium-webdriver' # <1>

driver = Selenium::WebDriver.for :chrome # <2>
driver.get 'https://rainypower.jp/' # <3>
