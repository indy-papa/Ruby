# frozen_string_literal: true

require 'open-uri'

URI.open('https://rainypower.jp/aboutus') do |f| # <1>
  f.each_line do |line|
    puts line
  end
end
