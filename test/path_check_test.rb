require 'minitest/autorun'
require 'minitest/pride'
require './lib/path_check'

class TestPathCheck < Minitest::Test

  def test_it_knows_root_path
    pc = PathCheck.new("/")
    assert_equal true, pc.root?
  end

  def test_it_knows_hello_path
    pc = PathCheck.new("/hello")
    assert_equal true, pc.hello?
  end

  def test_it_knows_date_time_path
    pc = PathCheck.new("/datetime")
    assert_equal true, pc.date_time?
  end

  def test_it_knows_shutdown_path
    pc = PathCheck.new("/shutdown")
    assert_equal true, pc.shutdown?
  end

  def test_it_knows_word_search_path
    pc = PathCheck.new("/wordsearch")
    assert_equal true, pc.word_search?
  end

  def test_it_knows_word_search_path
    pc = PathCheck.new("/game")
    assert_equal true, pc.game?
  end

  def test_it_knows_word_search_path
    pc = PathCheck.new("/startgame")
    assert_equal true, pc.start_game?
  end



end
