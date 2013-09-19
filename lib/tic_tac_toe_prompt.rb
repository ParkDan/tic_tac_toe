require './lib/game'

class TicTacToePrompt

  def header
    puts "********************************************************"
    puts "WELCOME TO CONSOLE TIC TAC TOE"
    puts "********************************************************"
  end

  def game_start
    header
    5.times do
      puts "Would you like to play one player or two? (1 or 2)"
      response = gets.chomp.to_i
      unless (1..2).include? response
        puts "sorry invalid response"
        next
      end
      game = Game.new
      game.implement_interface(response)
      break
    end
    puts "********************************************************"
    puts "GoodBye"
  end

end
