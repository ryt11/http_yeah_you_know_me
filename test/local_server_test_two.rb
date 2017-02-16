require 'faraday'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'



class ServerTest < Minitest::Test

  def test_shutdown_path_returns_expected
    far = Faraday.get("http://127.0.0.1:2000/shutdown")
    output = "<html><head><link rel='shortcut icon' href='about:blank'></head><body>Total requests: 2</body></html>"
    assert_equal output, far.body
  end
end
