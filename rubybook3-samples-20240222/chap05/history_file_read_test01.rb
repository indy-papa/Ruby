# frozen_string_literal: true

# Test class
class HistoryFileReadTest
  def run(filename)
    File.open(filename) do |file| # <1>
      file.each_line do |line| # <2>
        print line # <3>
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Order History File: #{ARGV[0]}"
  app = HistoryFileReadTest.new
  app.run(ARGV[0])
end
