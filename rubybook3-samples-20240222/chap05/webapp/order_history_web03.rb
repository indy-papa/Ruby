# frozen_string_literal: true

require 'webrick'
require 'erb'
require 'open3'
require_relative './term_names'

class OrderHistoryWebApp
  def initialize
    @config = {
      DocumentRoot: './',
      BindAddress: '127.0.0.1',
      Port: 8099
    }
    @server = WEBrick::HTTPServer.new(@config)
    WEBrick::HTTPServlet::FileHandler.add_handler('erb', WEBrick::HTTPServlet::ERBHandler)
    @server.config[:MimeTypes]['erb'] = 'text/html'
    trap('INT') { @server.shutdown }
    add_procs
  end

  def add_procs
    add_collect_proc
    add_list_proc
  end

  def run
    @server.start
  end

  def add_collect_proc
    @server.mount_proc('/collect') do |req, res|
      p req.query
      term = req.query['term']
      account = req.query['account']
      script = '../order_history_reporter.rb' # <1>
      file = "ohr-#{term}.output" # <2>
      # script = 'long_time_test.rb' # <3>
      # file = 'ohr-dummy.output' # <4>
      cmd = "ruby #{script} -t #{term} -a #{account} > #{file}"
      stdout, stderr, status = Open3.capture3(cmd)
      p stdout, stderr, status
      erb =
        if /exit 0/ =~ status.to_s
          'collected.erb'
        else
          'nocollected.erb'
        end
      template = ERB.new(File.read(erb))
      res.body << template.result(binding)
    end
  end

  def add_list_proc
    @server.mount_proc('/list') do |req, res|
      template = ERB.new(File.read('list.erb'))
      res.body << template.result(binding)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryWebApp.new
  app.run
end
