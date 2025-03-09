# frozen_string_literal: true

weight = 2.45253e03 # <1>
price_chicken_100g = 136 # <2>

printf "鶏肉 100グラム: %d円です。\n", price_chicken_100g
total = price_chicken_100g * weight / 100 # <3>
puts total # <4>
total = total.ceil # <5>
printf "鶏肉 %.2fグラム買ったので %d円です。\n", weight, total # <6>
