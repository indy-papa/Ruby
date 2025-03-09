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
    add_report_proc
    add_delete_proc # <1>
  end

  def run
    @server.start
  end

  def add_collect_proc
    @server.mount_proc('/collect') do |req, res|
      p req.query
      term = req.query['term']
      account = req.query['account']
      # script = '../order_history_reporter.rb'
      # file = "ohr-#{term}.output"
      script = 'long_time_test.rb'
      file = 'ohr-dummy.output'
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

  def add_report_proc
    @server.mount_proc('/report') do |req, res|
      p req.query
      term = req.query['term']
      file = req.query['file']
      account = req.query['account']
      template = ERB.new(File.read('report.erb'))
      res.body << template.result(binding)
    end
  end

  def add_delete_proc #<1>
    @server.mount_proc('/delete') do |req, res| # <2>
      p req.query
      term = req.query['term'] # <3>
      file = req.query['file'] # <4>
      begin # <5>
        File.delete(file) # <6>
        p "#{file} was deleted."
        erb = 'delete.erb' # <7>
      rescue => e # <8>
        errormsg = e # <9>
        erb = 'nodeleted.erb' # <10>
      end
      template = ERB.new(File.read(erb))
      res.body << template.result(binding)
    end
  end # <11>
end # <12>

if __FILE__ == $PROGRAM_NAME
  app = OrderHistoryWebApp.new
  app.run
end
