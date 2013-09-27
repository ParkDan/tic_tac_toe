require_relative 'io_interface'

class Player
  include IOInterface
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name, @symbol = name, symbol
  end

  def turn(board)
    while board.game_on?
      turn_prompt(@name)
      move = gets.chomp.split("")
      unless turn_input_check(move) && board.empty?(convert_turn_input(move))
        invalid
        next
      end
      board.assign_move(move, symbol)
      board.add_winner(@name) if board.game_victory_check
      board.add_count
      break
    end
  end

  # private

  def turn_input_check(move)
    char_arr = %w(a b c A B C)
    char_arr.include?(move[0]) && (1..3).include?(move[1].to_i) && move.length == 2
  end

  def convert_turn_input(move)
    move[0] = 0 if move[0] == "a" || move[0] == "A"
    move[0] = 1 if move[0] == "b" || move[0] == "B"
    move[0] = 2 if move[0] == "c" || move[0] == "C"
    move[1] = move[1].to_i-1
    move
  end
end
