# frozen_string_literal: true

require 'webrick'
require 'date'
require 'erb' # <1>

config = {
  DocumentRoot: './',
  BindAddress: '127.0.0.1',
  Port: 8099
}

server = WEBrick::HTTPServer.new(config)

server.mount_proc('/testprog') do |req, res|
  today = Date.today.to_s # <2>
  template = ERB.new(File.read('webrick03.erb')) # <3>
  res.body << template.result(binding) # <4>
end

trap('INT') { server.shutdown }

server.start

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryWebApp.new(ARGV)
  app.run
end
