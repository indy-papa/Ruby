# frozen_string_literal: true

require 'date' # <1>

honjitsu = Date.today # <2>
puts honjitsu # <3>

puts honjitsu.strftime('%D') # <4>
puts honjitsu.strftime('%Y年%m月%d日') # <5>
