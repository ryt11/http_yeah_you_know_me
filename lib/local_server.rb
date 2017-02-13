require 'socket'
require 'pry'
require './lib/parser'
require './lib/path_check'

class LocalServer
  attr_reader :parser, :path_string, :path_check
  attr_accessor :hello_counter, :request_count, :request_lines
  def initialize (port)
    @server = TCPServer.new(port)
    @parser = Parser.new
    @hello_counter = 0
    @request_count = 0
    @request_lines = nil
  end


  def read_request
    request_lines = []
    while line = @socket.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    @request_lines = request_lines.flatten(1)
    request_lines
  end

  def determine_response (path)
    path_check = PathCheck.new(path)
    if path_check.root?
      response = parser.debug_info(parser.split_request(@request_lines))
    elsif path_check.shutdown?
      response = "Total requests: #{@request_count}"
    elsif path_check.hello?
      response = "Hello World (#{hello_counter})"
      @hello_counter += 1
    elsif path_check.date_time?
      time  = DateTime.now
      response = time.strftime('%H:%M%p on %A, %B %d, %Y')
    else
      response = parser.debug_info(parser.split_request(@request_lines))
    end
    response
  end

  def send_response (response)
    html_wrapper = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>#{response}</body></html>"
    header = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{html_wrapper.length}\r\n\r\n"]
    if response == "Total requests: #{@request_count}"
      @socket.puts header
      @socket.puts html_wrapper
      exit!
    else
      @socket.puts header
      @socket.puts html_wrapper
    end
  end

  def close_stream
    @socket.close
  end

  def run
    loop do
      @socket = @server.accept
      @request_count += 1
      path = parser.split_request(read_request)[1]
      send_response(determine_response(path))
      close_stream
    end
  end

end

new_server = LocalServer.new(2000)
new_server.run
