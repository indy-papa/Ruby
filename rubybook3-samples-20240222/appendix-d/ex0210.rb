# frozen_string_literal: true

puts size = ARGV.size # <1>
p ARGV # <2>

if size > 2
  puts ARGV[0] # <3>
  puts ARGV[1]
end

ARGV.each do |arg| # <4>
  print arg
  print ' '
end

