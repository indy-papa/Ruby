# frozen_string_literal: true

require 'selenium-webdriver'
require_relative './account_info'

# Application class (OHR)
class OrderHistoryReporter # <1>
  include AccountInfo

  def initialize(account_file)
    @account = read(account_file)
    @amazon = AmazonManipulator.new
  end

  def collect_order_history # <2>
    title = @amazon.open_order_list
    puts title
    @amazon.change_order_term
    @amazon.collect_ordered_items
  end

  def make_report(order_list) # <3>
    puts "#{order_list.size} 件"
    order_list.each do |title|
      puts title
    end
  end

  def run # <4>
    @amazon.login(@account)
    order_list = collect_order_history
    @amazon.logout
    make_report(order_list)
  end

end

# Service class
class AmazonManipulator # <5>

  BASE_URL = 'https://www.amazon.co.jp/'

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 20)
  end

  def login(account) # <6>
    open_top_page
    open_login_page
    enter_mail_address(account[:email]) # <7>
    enter_password(account[:password]) # <8>
    wait_for_logged_in
  end

  def logout
    open_nav_link_popup
    wait_for_logged_out
  end

  def open_order_list
    element = @driver.find_element(:id, 'nav-orders')
    element.click
    @wait.until { @driver.find_element(:id, 'navFooter').displayed? }
    @driver.title
  end

  def change_order_term
    years = @driver.find_element(:name, 'orderFilter')
    select = Selenium::WebDriver::Support::Select.new(years)
    select.select_by(:value, 'year-2019')
    @wait.until { @driver.find_element(:id, 'navFooter').displayed? }
  end

  def collect_ordered_items # <9>
    title_list = []

    selector = '#ordersContainer .order > div:nth-child(2) .a-fixed-left-grid-col.a-col-right > div:nth-child(1)'
    titles = @driver.find_elements(:css, selector)
    titles.each { |t| title_list << t.text }
    title_list
  end

  private

  def wait_and_find_element(how, what)
    @wait.until { @driver.find_element(how, what).displayed? }
    @driver.find_element(how, what)
  end

  def open_top_page
    @driver.get BASE_URL
    wait_and_find_element(:id, 'navFooter')
  end

  def open_login_page
    element = wait_and_find_element(:id, 'nav-link-accountList')
    element.click
  end

  def enter_mail_address(email) # <1>
    element = wait_and_find_element(:id, 'ap_email')
    element.send_keys(email)
    @driver.find_element(:id, 'continue').click
  end

  def enter_password(password) # <2>
    element = wait_and_find_element(:id, 'ap_password')
    element.send_keys(password)
    @driver.find_element(:id, 'signInSubmit').click
  end

  def wait_for_logged_in
    wait_and_find_element(:id, 'nav-link-accountList')
  end

  def open_nav_link_popup
    element = wait_and_find_element(:id, 'nav-link-accountList')
    @driver.action.move_to(element).perform
  end

  def wait_for_logged_out
    element = wait_and_find_element(:id, 'nav-item-signout')
    element.click
    wait_and_find_element(:id, 'ap_email')
    @driver.quit
  end
end

if __FILE__ == $PROGRAM_NAME
  abort 'account file not specified.' unless ARGV.size == 1
  app = OrderHistoryReporter.new(ARGV[0]) # <1>
  app.run
end
