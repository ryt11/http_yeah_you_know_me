

class Game
  attr_reader  :answer
  attr_accessor :redirect, :guess_made, :current_guess, :guesses
  def initialize
    @answer = Random.rand(1..100)
    @guesses = 0
    @guess_made = false
    @redirect = false
    @current_guess = ''
  end

  def record_guess(guess)
    @current_guess = guess
    @guess_made = true
    @guesses += 1
  end

  def check_guess(guess)
    if guess.to_i == answer
      "correct!"
    elsif guess.to_i > answer
      "too high!"
    elsif guess.to_i < answer
      "too low!"
    end
  end

  def game_response
    "Guesses: #{guesses}<br><br>Your Guess: #{current_guess}, was #{check_guess(current_guess)}"
  end
end
