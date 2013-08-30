require './lib/computer_logic'
require './lib/player_logic'
require './lib/board_logic'
require './lib/user_interface'
require './lib/victory_conditions'
require './lib/player'

class TicTacToe
  include ComputerLogic
  include PlayerLogic
  include BoardLogic
  include UserInterface
  include VictoryConditions
  attr_accessor :board, :winner, :count, :symbol
  def initialize
    @symbol=['X','O']
    @board=[[" "," "," "],[" "," "," "],[" "," "," "]]
    @winner=""
    @count=0
  end
end
