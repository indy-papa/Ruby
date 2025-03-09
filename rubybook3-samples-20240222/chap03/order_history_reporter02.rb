# frozen_string_literal: true

require 'optparse' # <1>
require_relative './account_info'
require_relative './amazon_manipulator08' # <2>

# Application class (OHR)
class OrderHistoryReporter
  include AccountInfo

  def initialize(argv) # <3>
    @order_term = 'last30' # <4>
    parse_options(argv) # <5>
    @account = read(@account_file)
    @amazon = AmazonManipulator.new
  end

  def parse_options(argv) # <1>
    opts = OptionParser.new
    opts.banner = 'Usage: ruby order_history_reporter.rb [options]'
    opts.program_name = 'Order History Reporter'
    opts.version = [0, 2]
    opts.release = '2020-09-12'

    opts.on('-t TERM', '--term TERM',
            '注文履歴を取得する期間を指定する') do |t| # <2>
      term = 'last30' if t =~ /last/ # <3>
      term = 'months-3' if t =~ /month/ # <4>
      term = 'archived' if t =~ /arc/ # <5>
      term = "year-#{$1}" if t =~ /(\d\d\d\d)/ # <6>
      @order_term = term # <7>
    end
    opts.on('-a ACCOUNT', '--account ACCOUNT',
            'アカウント情報ファイルを指定する') do |a| # <8>
      @account_file = a
    end
    opts.on_tail('-v', '--version', 'バージョンを表示する') do
      puts opts.ver
      exit
    end

    opts.parse!(argv) # <9>
    puts "取得期間: #{@order_term}"
  end

  def collect_order_history
    title = @amazon.open_order_list
    puts title
    @amazon.change_order_term(@order_term) # <1>
    @amazon.collect_ordered_items
  end

  def make_report(order_infos)
    puts "#{order_infos.size} 件"
    order_infos.each do |id, rec|
      puts "ID: #{id}"
      rec.each do |key, val|
        puts format '%s: %s', key, val
      end
    end
  end

  def run
    @amazon.login(@account)
    order_infos = collect_order_history
    @amazon.logout
    make_report(order_infos)
  end

end

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryReporter.new(ARGV) # <1>
  app.run
end
