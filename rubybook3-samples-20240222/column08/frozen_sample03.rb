# frozen_string_literal: true 

require 'stringio' # <1>

str = StringIO.new # <2>
str << '私の好物は'
str << 'りんごです。'
puts str.string # <3>
