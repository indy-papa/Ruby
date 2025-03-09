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

    def login   # 1
        open_top_page
        open_login_page
        enter_mail_address
        enter_password
        wait_for_logged_in
    end

    def logout  # 2
        open_nav_link_popup
        wait_for_logged_out
    end

    def open_order_list
        element = @driver.find_element(:id, 'nav-orders')
        element.click
        @wait.until { @driver.find_element(:id, 'navFooter').displayed? }
        puts @driver.title
    end

    def change_order_term
        years = @driver.find_element(:id, 'orderFilter')
        select = Selenium::WebDriver::Support::Select.new(years)
        select.select_by(:value, 'year-2024')
        @wait.until { @driver.find_element(:id, 'navFooter').displayed? }
    end

    def list_ordered_items
        selector = '#a-page .a-box.delivery-box .a-fixed-left-grid-col.a-col-right > div:nth-child(1)'
        titles = @driver.find_elements(:css, selector)
        puts "#{titles.size} 件"
        titles.map { |t| puts t.text }
        sleep 10
    end

    def run     # 3
        login
        open_order_list
        change_order_term
        list_ordered_items
        logout
        sleep 10
        @driver.quit
    end

    private     # 4

    def wait_and_find_element(how, what)    # 5
        @wait.until{ @driver.find_element(how, what).displayed? }
        @driver.find_element(how, what)
    end

    def open_top_page   # 6
        @driver.get BASE_URL
        wait_and_find_element(:id, 'navFooter')
    end

    def open_login_page # 7
        element = wait_and_find_element(:id, 'nav-link-accountList')
        element.click
    end

    def enter_mail_address  # 8
        element = wait_and_find_element(:id, 'ap_email')
        element.send_keys(@account[:email])
        @driver.find_element(:id, 'continue').click
    end

    def enter_password  # 9
        element = wait_and_find_element(:id, 'ap_password')
        element.send_keys(@account[:password])
        @driver.find_element(:id, 'signInSubmit').click
    end

    def wait_for_logged_in  # 10
        wait_and_find_element(:id, 'nav-link-accountList')
    end

    def open_nav_link_popup # 11
        element = wait_and_find_element(:id, 'nav-link-accountList')
        @driver.action.move_to(element).perform
    end

    def wait_for_logged_out # 12
        element = wait_and_find_element(:id, 'nav-item-signout')
        element.click
        wait_and_find_element(:id, 'ap_email')
    end
end

if __FILE__ == $PROGRAM_NAME
    abort 'acount file not specified.' unless ARGV.size == 1
    app = AmazonManipulator.new(ARGV[0])
    app.run
end

