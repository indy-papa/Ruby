# frozen_string_literal: true

class OrderRecordReader
  def initialize(file)
    @file = file
    return unless block_given? # <1>

    yield self # <2>
  end

  def each # <3>
    until @file.eof
      rec = {}
      @file.each do |line|
        if /^(ID|注文番号|注文日|合計|明細):\s*(.+)/ =~ line
          rec[$1] = $2
        end
        break if rec.key?('明細') # <4>
      end
      return rec unless block_given? # <5>

      yield rec # <6>
    end
  end

end

if $PROGRAM_NAME == __FILE__
  File.open('order_sample03.txt', 'r') do |f|
    reader = OrderRecordReader.new(f) # <7>
    puts reader.each # <8>
    puts reader.each
  end

  puts '>----'

  File.open('order_sample03.txt', 'r') do |f|
    OrderRecordReader.new(f) do |reader| # <9>
      reader.each do |rec| # <10>
        puts rec 
      end
    end
  end
end
