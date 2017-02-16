require 'faraday'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'



class ServerTest < Minitest::Test

  def test_standard_path_returns_default
    far = Faraday.get("http://127.0.0.1:2000")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body><pre>Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: Faraday\nPort: \nOrigin: Faraday\nAccept: </pre></body></html>"
    assert_equal output, far.body
  end

  def test_hello_path_returns_expected
    far = Faraday.get("http://127.0.0.1:2000/hello")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>Hello World (0)</body></html>"
    assert_equal output, far.body
  end

  def test_date_time_path_returns_expected
    far = Faraday.get("http://127.0.0.1:2000/datetime")
    time  = DateTime.now
    response = time.strftime('%H:%M%p on %A, %B %d, %Y')
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>#{response}</body></html>"
    assert_equal output, far.body
  end

  def test_word_search_path_returns_expected_for_existing_word
    far = Faraday.get("http://127.0.0.1:2000/word_search?word=hello")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>Word is a known word.</body></html>"
    assert_equal output, far.body
  end

  def test_word_search_path_returns_expected_for_non_existent_word
    far = Faraday.get("http://127.0.0.1:2000/word_search?word=coivso")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>Word is not a known word.</body></html>"
    assert_equal output, far.body
  end

  def test_start_game_post_returns_expected
    far = Faraday.post("http://127.0.0.1:2000/startgame")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>Good luck!</body></html>"
    assert_equal output, far.body
  end


end
