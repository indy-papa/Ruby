# frozen_string_literal: true

require_relative 'order_sample01' # <1>

$orders['D01-9030194-5084203'].each_pair do |key, val| # <2>
  if key == '明細' # <3>
    puts key
    val.each do |details| # <4>
      puts "  #{details.join("\t")}" # <5>
    end
  else # <6>
    puts "#{key}: #{val}" # <7>
  end # <8>
end
