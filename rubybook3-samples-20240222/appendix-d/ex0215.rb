# frozen_string_literal: true

require_relative 'order_sample02'

$orders.each do |order| # <1>
  [:注文番号, :品名, :価格, :注文日].each do |detail_name| # <2>
    puts "#{detail_name}: #{order[detail_name]}" # <3>
  end
  puts '>----<'
end
