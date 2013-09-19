class Board
  attr_reader :board
  attr_accessor :count, :winner

  def initialize
    @board = [[" "," "," "],[" "," "," "],[" "," "," "]]
    @count = 0
    @winner = ""
  end

  def example
    puts "Please use a-c to refer to rows and 1-3 to refer to columns (e.g a2)"
    puts "   1   2   3 "
    puts "a    |   |   "
    puts "  ___|___|___"
    puts "b    |   |   "
    puts "  ___|___|___"
    puts "c    |   |   "
    puts "     |   |   "
    puts "********************************************************"
  end

  def display
    puts "   1   2   3 "
    puts "a  #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}  "
    puts "  ___|___|___"
    puts "b  #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}  "
    puts "  ___|___|___"
    puts "c  #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}  "
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
    @board[move[0]][move[1]] == " "
  end

  def game_over?
    @count == 9 || game_victory_check
  end

  def game_on?
    @count != 9 && !game_victory_check
  end

  def game_victory_check
    # horizontal win
    return true if @board[0][0] == @board[0][1] && @board[0][1] == @board[0][2] && !empty?([0,2])
    return true if @board[1][0] == @board[1][1] && @board[1][1] == @board[1][2] && !empty?([1,2])
    return true if @board[2][0] == @board[2][1] && @board[2][1] == @board[2][2] && !empty?([2,2])
    # vertical win
    return true if @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0] && !empty?([2,0])
    return true if @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1] && !empty?([2,1])
    return true if @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2] && !empty?([2,2])
    # diagonl win
    return true if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && !empty?([2,2])
    return true if @board[2][0] == @board[1][1] && @board[1][1] == @board[0][2] && !empty?([0,2])

    return false
  end

end
