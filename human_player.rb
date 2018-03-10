class HumanPlayer
  attr_reader :secret_word
  def pick_secret_word
    print "think of a word: "
    @secret_word = gets.chomp.downcase
    secret_word.size
  end
  def register_secret_length(length)
  end
  def handle_response(letter, indices)
  end
  def guess(board)
    print "pick a letter: "
    letter = gets.chomp.downcase
    return letter if ("a".."z") === letter
  end
  def check_guess(letter)
    size = secret_word.size
    (0...size).select{ |i| i if secret_word[i] == letter }
  end
end