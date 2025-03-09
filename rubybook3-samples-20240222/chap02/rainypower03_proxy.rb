# frozen_string_literal: true

require 'selenium-webdriver'

proxy = Selenium::WebDriver::Proxy.new(http: '140.227.229.208:3128') # <1>
caps   = Selenium::WebDriver::Remote::Capabilities.chrome(proxy: proxy) # <2>

driver = Selenium::WebDriver.for(:chrome, desired_capabilities: caps) # <3>
driver.get 'https://rainypower.jp/'

