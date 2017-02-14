require './lib/path_check'
require './lib/dictionary'
require './lib/parser'
require './lib/local_server'

class Response
  attr_reader :parser
  def initialize
    @parser = Parser.new
    @server = LocalServer.new
  end
  def determine_response (path) #could take this whole method and make it its' own class
    path_check = PathCheck.new(path)
    if path_check.root?
      response = parser.debug_info(@server.format_request)
    elsif path_check.shutdown?
      response = "Total requests: #{request_count}"
    elsif path_check.hello?
      response = "Hello World (#{hello_counter})"
      hello_counter += 1
    elsif path_check.date_time?
      time  = DateTime.now
      response = time.strftime('%H:%M%p on %A, %B %d, %Y')
    elsif path_check.word_search?
      new_dict = Dictionary.new
        if new_dict.check_dictionary(parser.get_params_requested(@server.format_request)) #can I split this into a method later?
          response = "Word is a known word."
        else
          response = "Word is not a known word."
        end
    elsif path_check.game?
      #game handle
    elsif path_check.start_game?
      #start_game handle
    else
      response = parser.debug_info(@server.format_request)
    end
    response
  end

end
