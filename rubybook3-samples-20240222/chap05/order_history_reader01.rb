# frozen_string_literal: true

# 注文履歴を1レコードずつ読み込むためのクラス
class OrderHistoryReader # <1>
  def initialize(filename, mode = 'r') # <2>
    @file = File.open(filename, mode) # <3>
    return unless block_given? # <4>

    yield self # <5>
    @file.close # <6>
  end

  def each # <7>
    until @file.eof # <8>
      record = {} # <9>
      @file.each do |line| # <10>
        if /^(ID|注文番号|注文日|合計|お届け先|明細):\s*(.+)/ =~ line # <11>
          record[$1] = $2 # <12>
        end
        break if record.key?('明細') # <13>
      end
      p record
      record['お届け先'] = '指定なし' unless record.key?('お届け先') # <14>
      yield record # <15>
    end
  end

  def close
    @file.close
  end
end

# Test class
class HistoryFileReadTest # <1>
  def put_record(rec) # <2>
    puts '----------'
    rec.each do |key, value|
      puts "#{key}| #{value}"
    end
  end

  def run1(filename)
    OrderHistoryReader.new(filename) do |reader| # <3>
      reader.each do |rec| # <4>
        put_record(rec)
      end
    end
  end

  def run2(filename)
    reader = OrderHistoryReader.new(filename) # <5>
    reader.each do |rec| # <6>
      put_record(rec)
    end
    reader.close # <7>
  end
end

if __FILE__ == $PROGRAM_NAME  # <1>
  puts "Order History File: #{ARGV[0]}"
  app = HistoryFileReadTest.new # <2>
  app.run1(ARGV[0]) # <3>
  puts '=========='
  app.run2(ARGV[0]) # <4>
end
