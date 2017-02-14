require 'pry'
class Dictionary
  attr_reader :dictionary
  def initialize
    @dictionary = File.open("/usr/share/dict/words", "r").read.split("\n")
  end

  def check_dictionary (word)
    dictionary.any? {|dict_word| dict_word == word}
  end
end
