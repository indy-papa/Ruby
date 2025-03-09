# frozen_string_literal: true

n = 2
m = 5
price_socks = 520
price_stickies = 890

puts '1足' + price_socks.to_s + '円のソックスが' + n.to_s + '足あります。' # <1>
printf "1足%d円のソックスが%d足あります。\n", price_socks, n # <2>
puts sprintf '1個%d円のふせん紙が%d個あります。', price_stickies, m # <3>
fmt = '1個%d円のふせん紙が%d個あります。' # <4>
puts format fmt, price_stickies, m # <5>
