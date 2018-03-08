class ComputerPlayer
  attr_reader :secret_word
  def initialize
    @dict = File.readlines("dictionary.txt").map(&:chomp)
  end
  def pick_secret_word
    @secret_word = @dict.sample
    secret_word.size
  end
  def register_secret_length(len)
    @candidate_words = @dict.select{ |word| word.size == len }
  end
  def check_guess(letter)
    word = secret_word.chars
    word.each_index.select{ |i| i if word[i] == letter }
  end
  def handle_response(letter, indices)
    @response = [letter, indices]
    @candidate_words.reject!{ |word| no_match?(word) }
  end
  def guess(board)
    return random_guess if @candidate_words.empty?
    words = @candidate_words.uniq.join
    board.each{ |letter| words.delete!(letter) if letter }
    result = count_letters(words).sort_by(&:last)
    result.last.first
  end
  private
  def random_guess
    ("a".."z").to_a.sample
  end
  def no_match?(word)
    letter, indices = @response
    return word.include?(letter) if indices.empty?
    return true unless word.count(letter) == indices.size
    indices.any?{ |i| word[i] != letter }
  end
  def count_letters(word)
    count = Hash.new(0)
    word.each_char{ |letter| count[letter] += 1 }
    count
  end
end