# frozen_string_literal: true

require 'open-uri' # <1>

URI.open('https://rainypower.jp/') do |f| # <2>
  f.each_line do |line| # <3>
    puts line # <4>
  end
end
