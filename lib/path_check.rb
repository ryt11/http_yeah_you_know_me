class PathCheck
  attr_reader :path
  def initialize (path)
    @path = path
  end

  def root?
    path == "/"
  end

  def hello?
    path == "/hello"
  end

  def date_time?
    path == "/datetime"
  end

  def shutdown?
    path == "/shutdown"
  end

  def word_search?
    path == "/wordsearch"
  end

  def game?
    path == "/game"
  end

  def start_game?
    path == "/startgame"
  end
end
