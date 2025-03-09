# frozen_string_literal: true

require_relative 'ex0216' # <1>

orders = OrderHistory.new

rec = OrderRecord.new(
  '249-7759973-2113414', 'UNIX: A History and a Memoir',
  '￥ 2,259', '2019年11月17日'
)
orders.append(rec)

rec2 = OrderRecord.new(
  'D01-9030194-5084203', '世界チャンピオンの紙飛行機ブック',
  '￥ 2,420', '2019年10月13日'
)
orders.append(rec2)

File.open('ex0217.output', 'w') do |f| # <2>
  f.print orders.report # <3>
end

File.open('ex0217.output', 'r') do |f| # <4>
  f.each do |line| # <5>
    print line # <6>
  end
end
