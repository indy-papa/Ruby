# frozen_string_literal: true

require 'optparse'

opts = OptionParser.new
opts.banner = 'Usage: ruby optparse02.rb [options]'
opts.program_name = 'SampleProgram-02'
opts.version = [0, 2]
opts.release = '2020-09-12'

opts.on('-y YEAR', '--year YEAR', '注文履歴を取得する年を指定する') do |y| # <1>
  @order_year = y # <2>
end

opts.on_tail('-v', '--version', 'バージョンを表示する') do
  puts opts.ver
  exit
end

opts.parse!(ARGV)
puts "取得年は #{@order_year}" # <3>
