# frozen_string_literal: true

price0 = '合計: ￥ 123,456,789'
price1 = '\123'
p price0.split(/\D+/).join # <1>
p price1.split(/\D+/).join
