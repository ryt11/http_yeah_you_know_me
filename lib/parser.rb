class Parser
  attr_accessor :post, :get
  def initialize
    @post = false
    @get = false
  end

  def debug_info(split_it)
    host_and_port = split_it[4].split(":")
    "<pre>Verb: #{split_it[0]}\nPath: #{split_it[1]}\nProtocol: #{split_it[2]}\nHost: #{host_and_port[0]}\nPort: #{host_and_port[1]}\nOrigin: #{host_and_port[0]}\nAccept: #{split_it[26]}</pre>"
  end

  def split_request(request)
    split = request.map! do |line|
      line.split(' ')
    end
    split.flatten(1)[0] == "GET" ? @get = true : @post = true
    split.flatten(1)
  end



  def get_path_requested (request_info)
    request_info[1].include?("?") ? path = request_info[1].split("?").first : path = request_info[1]
  end

  def get_params_requested (request_info)
    request_info[1].split("?")[1].split('=')[1]
   #if there is not a second param and no end will it not do anything?
  end

end
