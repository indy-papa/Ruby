# frozen_string_literal: true

require 'webrick'
require 'erb'
require 'open3' # <1>
require_relative './term_names'

class OrderHistoryWebApp
  def initialize
    @config = {
      DocumentRoot: './',
      BindAddress: '127.0.0.1',
      Port: 8099
    }
    @server = WEBrick::HTTPServer.new(@config)
    WEBrick::HTTPServlet::FileHandler.add_handler('erb', WEBrick::HTTPServlet::ERBHandler) # <2>
    @server.config[:MimeTypes]['erb'] = 'text/html' # <3>
    trap('INT') { @server.shutdown }
    add_procs # <4>
  end

  def add_procs
    add_collect_proc # <5>
  end

  def run # <6>
    @server.start
  end

  def add_collect_proc # <7>
    @server.mount_proc('/collect') do |req, res| # <8>
      p req.query # <9>
      term = req.query['term'] # <10>
      account = req.query['account'] # <11>
      # script = '../order_history_reporter.rb' # <12>
      # file = "ohr-#{term}.output"
      script = 'long_time_test.rb' # <13>
      file = 'ohr-dummy.output'
      cmd = "ruby #{script} -t #{term} -a #{account} > #{file}" # <14>
      stdout, stderr, status = Open3.capture3(cmd) # <15>
      p stdout, stderr, status # <16>
      erb =
        if /exit 0/ =~ status.to_s # <17>
          'collected.erb'
        else
          'nocollected.erb'
        end
      template = ERB.new(File.read(erb))
      res.body << template.result(binding) # <18>
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryWebApp.new
  app.run
end
