class Parser
  def debug_info(split_it)
    host_and_port = split_it[4].split(":")
    "<pre>Verb: #{split_it[0]}\nPath: #{split_it[1]}\nProtocol: #{split_it[2]}\nHost: #{host_and_port[0]}\nPort: #{host_and_port[1]}\nOrigin: #{host_and_port[0]}\nAccept: #{split_it[26]}</pre>"
  end

  def split_request(request)
    split = request.map! do |line|
      line.split(' ')
    end
    split.flatten(1)
  end

end
