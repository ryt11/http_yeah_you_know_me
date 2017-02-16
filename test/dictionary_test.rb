require "minitest/autorun"
require "minitest/pride"
require "./lib/dictionary"

class TestDictionary < Minitest::Test
  attr_reader :dict

  def setup
    @dict = Dictionary.new
  end

  def test_it_can_check_dictionary_for_actual_word
    assert_equal true, dict.check_dictionary("hello")
  end

  def test_it_can_check_dictionary_for_invalid_word
    assert_equal false, dict.check_dictionary("xzcz")
  end

end
