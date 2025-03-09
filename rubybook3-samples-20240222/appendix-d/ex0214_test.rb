# frozen_string_literal: true

require_relative 'ex0214'

app = Greeting.new
app.say_hello

puts "#{$PROGRAM_NAME}, #{__FILE__}" # <1>
