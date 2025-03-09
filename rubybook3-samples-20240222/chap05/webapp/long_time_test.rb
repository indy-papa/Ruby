# frozen_string_literal: true

# 時間のかかる処理を代替するスクリプト
class LongTimeTest
  def run
    puts 'start'
    sleep(10) # <1>
    puts 'end'
  end
end

if __FILE__ == $PROGRAM_NAME
  app = LongTimeTest.new
  app.run
  if ARGV.include? 'account.json' # <2>
    puts 'OK.'
    exit true # <3>
  else
    puts 'ERROR.'
    exit false # <4>
  end
end
