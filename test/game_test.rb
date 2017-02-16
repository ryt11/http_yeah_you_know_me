require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class TestGame < Minitest::Test
  attr_reader :game
  def setup
    @game = Game.new
  end

  def test_it_can_record_guess
    game.record_guess(3)
    assert_equal 3, game.current_guess
  end

  def test_it_can_count_guesses
    game.record_guess(3)
    game.record_guess(3)
    game.record_guess(3)
    game.record_guess(3)
    game.record_guess(3)
    assert_equal 5, game.guesses
  end

end
