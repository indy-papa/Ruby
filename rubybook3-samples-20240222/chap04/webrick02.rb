# frozen_string_literal: true

require 'webrick'
require 'date' # <1>

config = {
  DocumentRoot: './',
  BindAddress: '127.0.0.1',
  Port: 8099
}

server = WEBrick::HTTPServer.new(config)

server.mount_proc('/testprog') do |req, res| # <2>
  res.body << '<html lang="ja">'
  res.body << '<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /></head>'
  res.body << "<body><p>アクセスした日付は#{Date.today}です。</p>" # <3>
  res.body << "<p>リクエストのパスは#{req.path}でした。</p>" # <4>
  res.body << '<table border=1>'
  req.each do |key, value|
    res.body << "<tr><td >#{key}</td><td>#{value}</td></tr>" # <5>
  end
  res.body << '</table></body></html>'
end

trap('INT') { server.shutdown }

server.start

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryWebApp.new(ARGV)
  app.run
end
