# frozen_string_literal: true

n = 2
m = 5
price_socks = 520
price_stickies = 890

puts "1個#{price_stickies}円のふせん紙が#{m}個あります。"
str = '1足' << price_socks.to_s << '円のソックスが' << n.to_s << '足あります。' # <1>
puts str

