# frozen_string_literral: true

require 'selenium-webdriver'
require_relative './account_info'

class AmazonManipulator
    include AccountInfo
    def run
        abort 'acount file not specified.' unless ARGV.size == 1
        #account = read_account(ARGV[0])
        account = read(ARGV[0])

        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 20)

        driver.get 'https://www.amazon.co.jp'
        element = driver.find_element(:id, 'nav-link-accountList')
        puts element.text
        element.click

        wait.until { driver.find_element(:id, 'ap_email').displayed? }
        puts driver.title
        element = driver.find_element(:id, 'ap_email')
        element.send_keys(account[:email])
        element = driver.find_element(:id, 'continue')
        element.click

        wait.until { driver.find_element(:id, 'ap_password').displayed? }
        element = driver.find_element(:id, 'ap_password')
        element.send_keys(account[:password])

        element = driver.find_element(:id, 'auth-signin-button')
        element.click
        wait.until { driver.find_element(:id, 'nav-link-accountList').displayed? }

        sleep 10
        driver.quit
    end
end

if __FILE__ == $PROGRAM_NAME
    app = AmazonManipulator.new
    app.run
end

