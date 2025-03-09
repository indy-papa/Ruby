# frozen_string_literal: true

detail = ['μITRONによる組込みシステム入門', '武井 正彦', '販売: アマゾンジャパン合同会社', '￥ 3,080'] # <1>

detail.each do |item| # <2>
  puts item # <3>
end

puts 'a)---'
puts "最初の要素: #{detail[0]}" # <4>
puts "最後の要素: #{detail[-1]}" # <5>

puts 'b)----'
p detail.index('￥ 3,080') # <6>

puts 'c)----'
p detail.include?('￥ 3,080') # <7>

puts 'd)----'
detail.append('返品期間：2020/01/20まで') # <8>
p detail

puts 'e)----'
detail.delete('販売: アマゾンジャパン合同会社') # <9>
p detail
