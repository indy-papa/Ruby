# frozen_string_literral: true

require 'selenium-webdriver'
require_relative './account_info'

class AmazonManipulator
    include AccountInfo
    BASE_URL = 'https://www.amazon.co.jp'

    def initialize(account_file)
        @driver = Selenium::WebDriver.for :chrome
        @wait = Selenium::WebDriver::Wait.new(timeout: 20)
        @account = read(account_file)
    end

    def login
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

        element = @driver.find_element(:id, 'auth-signin-button')
        element.click
        @wait.until { @driver.find_element(:id, 'nav-link-accountList').displayed? }
    end

    def logout
        @wait.until { @driver.find_element(:id, 'nav-link-accountList').displayed? }
        element = @driver.find_element(:id, 'nav-link-accountList')
        @driver.action.move_to(element).perform
        @wait.until { @driver.find_element(:id, 'nav-item-signout').displayed? }
        element = @driver.find_element(:id, 'nav-item-signout')
        element.click
        @wait.until { @driver.find_element(:id, 'ap_email').displayed? }
    end

    def run
        login
        sleep 10
        logout
        sleep 10
        @driver.quit
    end
end

if __FILE__ == $PROGRAM_NAME
    abort 'acount file not specified.' unless ARGV.size == 1
    app = AmazonManipulator.new(ARGV[0])
    app.run
end

