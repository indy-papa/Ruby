# frozen_string_literal: true

require 'stringio' # <1>

class OrderRecord # <2>
  attr_reader :detail # <3>

  def initialize(id, name, price, date) # <4>
    @detail = { 注文番号: id, 品名: name, 価格: price, 注文日: date } # <5>
  end
end

class OrderHistory # <6>
  def initialize
    @orders = [] # <7>
  end

  def append(record) # <8>
    @orders.append(record) # <9>
  end

  def report # <10>
    report = StringIO.new # <11>
    report.puts "件数: #{@orders.size}件" # <12>
    report.puts '>------<'
    @orders.each do |rec| # <13>
      [:品名, :価格].each do |detail_name| # <14>
        report.puts "#{detail_name}: #{rec.detail[detail_name]}" # <15>
      end
      report.puts '>------<'
    end
    return report.string # <16>
  end
end

if $PROGRAM_NAME == __FILE__
  orders = OrderHistory.new # <17>

  rec = OrderRecord.new( # <18>
    '249-7759973-2113414', 'UNIX: A History and a Memoir',
    '￥ 2,259', '2019年11月17日'
  )
  orders.append(rec) # <19>

  rec2 = OrderRecord.new(
    'D01-9030194-5084203', '世界チャンピオンの紙飛行機ブック',
    '￥ 2,420', '2019年10月13日'
  )
  orders.append(rec2)

  puts '1)----<'
  puts rec.detail
  puts '2)----<'
  puts rec2.detail[:注文日]
  puts '3)----<'
  print orders.report # <20>
end
