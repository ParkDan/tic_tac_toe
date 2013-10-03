require 'io_interface'
require 'player_console_move'

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
      break
    end
  end
end
