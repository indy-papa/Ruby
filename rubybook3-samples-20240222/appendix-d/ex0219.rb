# frozen_string_literal: true

class OrderRecordReader #<1>
  def initialize(file)
    @file = file # <2>
  end

  def read # <3>
    until @file.eof # <4>
      rec = {}
      @file.each do |line|
        if /^(ID|注文番号|注文日|合計|明細):\s*(.+)/ =~ line  # <5>
          key = $1
          rec[key] = $2
          return rec if rec.key?('明細') # <6>
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  File.open('order_sample03.txt', 'r') do |f| # <7>
    reader = OrderRecordReader.new(f) # <8>
    loop do # <9>
      rec = reader.read # <10>
      break unless rec # <11>

      puts rec # <12>
    end
  end
end
