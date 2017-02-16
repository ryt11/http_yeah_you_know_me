require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'


class ParserTest < Minitest::Test
  attr_reader :par, :request, :parse_items
  def setup
    @par = Parser.new
    @request = ["GET /wordsearch?word=hello HTTP/1.1",
 "Host: 127.0.0.1:2000",
 "Connection: keep-alive",
 "Cache-Control: max-age=0",
 "Upgrade-Insecure-Requests: 1",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
 "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
 "Accept-Encoding: gzip, deflate, sdch, br",
 "Accept-Language: en-US,en;q=0.8"]


    @parse_items = ["GET",
 "/wordsearch?word=hello",
 "HTTP/1.1",
 "Host:",
 "127.0.0.1:2000",
 "Connection:",
 "keep-alive",
 "Cache-Control:",
 "max-age=0",
 "Upgrade-Insecure-Requests:",
 "1",
 "User-Agent:",
 "Mozilla/5.0",
 "(Macintosh;",
 "Intel",
 "Mac",
 "OS",
 "X",
 "10_11_6)",
 "AppleWebKit/537.36",
 "(KHTML,",
 "like",
 "Gecko)",
 "Chrome/56.0.2924.87",
 "Safari/537.36",
 "Accept:",
 "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
 "Accept-Encoding:",
 "gzip,",
 "deflate,",
 "sdch,",
 "br",
 "Accept-Language:",
 "en-US,en;q=0.8"]

  end

  def test_it_exists
    assert_instance_of Parser, par
  end
  def test_it_can_split_request
    assert_equal parse_items, par.split_request(request)
  end

  def test_debug_info
    parse_info = par.split_request(request)
    assert_equal "<pre>Verb: GET\nPath: /wordsearch?word=hello\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 2000\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8</pre>", par.debug_info(parse_info)
  end

  def test_it_can_find_path_requested
   assert_equal "/wordsearch", par.get_path_requested(parse_items)
  end

  def test_it_can_find_params
    assert_equal "hello", par.get_params_requested(parse_items)
  end



end
