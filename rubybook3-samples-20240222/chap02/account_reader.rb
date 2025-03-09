# frozen_string_literal: true

require 'json' # <1>

def read_account(filename)
  File.open(filename) do |file| # <2>
    JSON.parse(File.read(file), symbolize_names: true) # <3>
  end
end

if __FILE__ == $PROGRAM_NAME # <4>
  account = read_account(ARGV[0]) # <5>
  p account # <6>
  puts account[:email] # <7>
  puts account[:password]
end
