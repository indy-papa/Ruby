# frozen_string_literal: true

class Greeting
  def say_hello
    puts 'Hello!'
    puts "#{$PROGRAM_NAME}, #{__FILE__}" # <1>
  end
end

if __FILE__ == $PROGRAM_NAME # <2>
  app = Greeting.new
  app.say_hello
end
