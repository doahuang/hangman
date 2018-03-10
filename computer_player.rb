class ComputerPlayer
  attr_reader :secret_word
  def initialize
    @dict = File.readlines("dictionary.txt")
    @dict.map!(&:chomp)
    @hot_letters = "etaoinshrdlcumwfgypbvkjxqz".chars
  end
  def pick_secret_word
    @secret_word = @dict.sample
    secret_word.size
  end
  def register_secret_length(length)
    @dict.select!{ |word| word.size == length }
  end
  def check_guess(letter)
    size = secret_word.size
    (0...size).select{ |i| i if secret_word[i] == letter }
  end
  def handle_response(letter, indices)
    @dict.reject! do |word|
      freq_fail = (word.count(letter) != indices.size)
      pos_fail = indices.any?{ |i| word[i] != letter }
      freq_fail || pos_fail
    end
  end
  def guess(board)
    table = letter_freq(board).sort_by(&:last)
    letter = table.empty? ? @hot_letters.first : table.last.first
    @hot_letters.delete(letter)
    letter
  end
  private
  def letter_freq(board)
    table = Hash.new(0)
    @dict.each do |word|
      board.each_with_index do |letter, i|
        next if letter
        table[word[i]] += 1
      end
    end
    table
  end
end