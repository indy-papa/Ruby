# frozen_string_literal: true

require 'webrick' # <1>

config = {
  DocumentRoot: './', # <2>
  BindAddress: '127.0.0.1', # <3>
  Port: 8099 # <4>
}

server = WEBrick::HTTPServer.new(config) # <5>

trap('INT') { server.shutdown } # <6>

server.start # <7>

