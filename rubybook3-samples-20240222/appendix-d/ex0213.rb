# frozen_string_literal: true

require_relative 'order_sample01'

$orders['D01-9030194-5084203'].each_pair do |key, val|
  total = 0
  next unless key == '明細' # <1>

  val.each do |detail| 
    detail.each do |item| # <2>
      next unless /￥\s*(\d+)/ =~item # <3>

      price = $1.to_i # <4>
      puts "価格: #{price}円" # <5>
      total += price # <6>
    end
  end
  puts "合計: #{total}円" # <7>
end
