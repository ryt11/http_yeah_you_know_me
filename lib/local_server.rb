require 'socket'
require 'pry'
require './lib/parser'
require './lib/path_check'
require './lib/dictionary'
require './lib/game'


class LocalServer
  attr_reader :parser, :path_string, :path_check, :game
  attr_accessor :hello_counter, :request_count, :request_lines, :running

  def initialize (port)
    @server = TCPServer.new(port)
    @parser = Parser.new
    @running = true
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
    @request_lines
  end


  def determine_response (path) #could take this whole method and make it its' own class
    path_check = PathCheck.new(path)
    if path_check.root?
      response = parser.debug_info(format_request)
    elsif path_check.shutdown?
      response = "Total requests: #{request_count}"
    elsif path_check.hello?
      response = "Hello World (#{hello_counter})"
      @hello_counter += 1
    elsif path_check.date_time?
      time  = DateTime.now
      response = time.strftime('%H:%M%p on %A, %B %d, %Y')
    elsif path_check.word_search?
      new_dict = Dictionary.new
        if new_dict.check_dictionary(parser.get_params_requested(format_request)) #can I split this into a method later?
          response = "Word is a known word."
        else
          response = "Word is not a known word."
        end
    elsif path_check.game? && parser.get
      game.guess_made == true ? response = game.game_response : response = "You must make a guess."
      parser.get = false
    elsif path_check.game? && parser.post
      game.redirect = true
      game.record_guess(parser.get_params_requested(format_request))
      parser.post = false
    elsif path_check.start_game? && parser.post
      @game = Game.new
      response = "Good luck!"
      parser.post = false
    else
      response = parser.debug_info(format_request)
    end
    response
  end


  def send_response (response)
    html_wrapper = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>#{response}</body></html>"
    if game != nil && game.redirect
      header = ["http/1.1 302 Moved Permanently",
        "Location: http://127.0.0.1:2000/game",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{html_wrapper.length}\r\n\r\n"]
      game.redirect = false
    else
      header = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{html_wrapper.length}\r\n\r\n"]
    end
    if response == "Total requests: #{@request_count}"
      @socket.puts header
      @socket.puts html_wrapper
      @running = false
    else
      @socket.puts header
      @socket.puts html_wrapper
    end
  end


  def format_request
    parser.split_request(@request_lines.flatten(1))
  end


  def close_stream
    @socket.close
  end


  def run
    while running
      @socket = @server.accept
      @request_count += 1
      read_request
      send_response(determine_response(parser.get_path_requested(format_request)))
      close_stream
    end
  end

end

new_server = LocalServer.new(2000)
new_server.run
