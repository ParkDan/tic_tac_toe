require_relative 'io_interface'
require_relative 'player_console_move'

class Player
  include IOInterface
  include PlayerConsoleMove

  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name, @symbol = name, symbol
  end

  def turn(board)
    while board.game_on?
      board.assign_move(get_move(board), symbol)
      board.add_winner(@name) if board.game_victory_check
      board.add_count
      break
    end
  end
end
