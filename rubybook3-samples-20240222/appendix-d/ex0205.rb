# frozen_string_literal: true

n = 2
m = 5
price_socks = 520
price_stickies = 890

subtotal_socks = price_socks * m # <1>
subtotal_stickies = price_stickies * n
total = subtotal_socks + subtotal_stickies # <2>
printf "合計%d円です。\n", total
