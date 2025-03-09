# frozen_string_literal: true

require 'optparse' # <1>

opts = OptionParser.new # <2>
opts.banner = 'Usage: ruby optparse01.rb [options]' # <3>
opts.program_name = 'SampleProgram-01' # <4>
opts.version = [0, 2] # <5>
opts.release = '2020-09-12' # <6>

opts.on_tail('-v', '--version', 'バージョンを表示する') do # <7>
  puts opts.ver # <8>
  exit # <9>
end

opts.parse!(ARGV) # <10>

