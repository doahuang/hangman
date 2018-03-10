require_relative "human_player"
require_relative "computer_player"

class Hangman
  attr_reader :guesser, :referee, :board
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
  end
  def play
    setup
    10.times do
      render
      take_turn
      break if won?
    end
    render
    game_over
  end
  private
  def render
    intro
    draw = board.map{ |letter| letter ? letter : "_" }
    puts " " + draw.join(" ")
    puts
  end
  def setup
    length = referee.pick_secret_word
    guesser.register_secret_length(length)
    @board = Array.new(length)
  end
  def take_turn
    letter = guesser.guess(board)
    indices = referee.check_guess(letter)
    update_board(letter, indices)
    guesser.handle_response(letter, indices)
  end
  def update_board(letter, indices)
    indices.each{ |i| board[i] = letter }
  end
  def won?
    board.join == referee.secret_word
  end
  def game_over
    puts "game over, guesser " + (won? ? "win!" : "lose!")
    puts "the word is \"#{referee.secret_word}\""
  end
end

def intro
  system("clear") || system("cls")
  puts "let's play hangman!"
  puts
end

def init_player(role)
  print "choose computer (enter) or human (y) as #{role}: "
  gets.chomp == "" ? ComputerPlayer.new : HumanPlayer.new
end

if $PROGRAM_NAME == __FILE__
  intro
  guesser = init_player("guesser")
  referee = init_player("referee")
  players = { guesser: guesser, referee: referee }
  Hangman.new(players).play
end