require 'constants'
require 'io_interface'

class Board
  include IOInterface
  include Constants

  attr_reader :board, :winner

  def initialize
    @board, @winner = [[" "," "," "],[" "," "," "],[" "," "," "]], ""
  end

  def game_victory_check
    l_win_check(0, 1, 2) || l_win_check(3, 4, 5) || l_win_check(6, 7, 8) ||
    l_win_check(0, 3, 6) || l_win_check(1, 4, 7) || l_win_check(2, 5, 8) ||
    l_win_check(0, 4, 8) || l_win_check(2, 4, 6)
  end

  def l_win_check(pos1, pos2, pos3)
    position(POS_ARY[pos1]) == position(POS_ARY[pos2]) && position(POS_ARY[pos2]) == position(POS_ARY[pos3]) && !empty?(POS_ARY[pos3])
  end

  def display() display_output { |i| position(POS_ARY[i])} end

  def p_eql?(move1, move2, symbol) position(move1) == position(move2) && position(move1) == symbol end

  def add_winner(winner) @winner = winner end

  def example() instructions; display end

  def assign_move(move, symbol) @board[move[0]][move[1]] = symbol; display end

  def position(move) @board[move[0]][move[1]] end

  def empty?(move) @board[move[0]][move[1]].strip.empty? end

  def stalemate?() count == 9 && @winner.empty? end

  def game_over?() count == 9 || game_victory_check end

  def game_on?() count != 9 && !game_victory_check end

  def available_moves()
    valid_move_array=[]
    POS_ARY.each { |pos| valid_move_array << pos if empty?(pos) }
    valid_move_array
  end

  def count() 9 - available_moves.length end

end
