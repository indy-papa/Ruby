# frozen_string_literal: true

require 'open-uri'

URI.open('https://rainypower.jp/',
        { proxy: 'http://140.227.229.208:3128' }) do |f| # <1>
  f.each_line do |line|
    puts line
  end
end
