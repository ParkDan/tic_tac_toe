require './lib/position_constants'

class Board
  include PositionConstants

  attr_reader :board
  attr_accessor :count, :winner

  def initialize
    @board = [[" "," "," "],[" "," "," "],[" "," "," "]]
    @count = 0
    @winner = ""
  end

  def example
    puts "Please use a-c to refer to rows and 1-3 to refer to columns (e.g a2)"
    display
  end

  def display
    puts "   1   2   3 "
    puts "a  #{position(TOP_LEFT)} | #{position(TOP_MID)} | #{position(TOP_RIGHT)}  "
    puts "  ___|___|___"
    puts "b  #{position(MID_LEFT)} | #{position(CENTER)} | #{position(MID_RIGHT)}  "
    puts "  ___|___|___"
    puts "c  #{position(BOT_LEFT)} | #{position(BOT_MID)} | #{position(BOT_RIGHT)}  "
    puts "     |   |   "
    puts "********************************************************"
  end

  def assign_move(move, symbol)
    @board[move[0]][move[1]] = symbol
    display
  end

  def position(move)
    @board[move[0]][move[1]]
  end

  def empty?(move)
    @board[move[0]][move[1]].strip.empty?
  end

  def stalemate?
    @count == 9 && @winner.empty?
  end

  def game_over?
    @count == 9 || game_victory_check
  end

  def game_on?
    @count != 9 && !game_victory_check
  end

  def game_victory_check
    # horizontal win
    return true if position(TOP_LEFT) == position(TOP_MID) && position(TOP_MID) == position(TOP_RIGHT) && !empty?(TOP_RIGHT)
    return true if position(MID_LEFT) == position(CENTER) && position(CENTER) == position(MID_RIGHT) && !empty?(MID_RIGHT)
    return true if position(BOT_LEFT) == position(BOT_MID) && position(BOT_MID) == position(BOT_RIGHT) && !empty?(BOT_RIGHT)
    # vertical win
    return true if position(TOP_LEFT) == position(MID_LEFT) && position(MID_LEFT) == position(BOT_LEFT) && !empty?(BOT_LEFT)
    return true if position(TOP_MID) == position(CENTER) && position(CENTER) == position(BOT_MID) && !empty?(BOT_MID)
    return true if position(TOP_RIGHT) == position(MID_RIGHT) && position(MID_RIGHT) == position(BOT_RIGHT) && !empty?(BOT_RIGHT)
    # diagonl win
    return true if position(TOP_LEFT) == position(CENTER) && position(CENTER) == position(BOT_RIGHT) && !empty?(BOT_RIGHT)
    return true if position(BOT_LEFT) == position(CENTER) && position(CENTER) == position(TOP_RIGHT) && !empty?(TOP_RIGHT)

    return false
  end
end
