require_relative 'game'
require_relative 'io_interface'

class TicTacToePrompt
  include IOInterface

  def game_start
    header
    5.times do
      one_two_prompt
      response = get_response.to_i
      unless (1..2).include? response
        invalid
        next
      end
      game = Game.new
      game.implement_interface(response)
      break
    end
    goodbye
  end
end
