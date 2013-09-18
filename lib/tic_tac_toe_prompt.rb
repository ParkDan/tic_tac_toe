require './lib/game'

class TicTacToePrompt

  def header
    puts "********************************************************"
    puts "WELCOME TO CONSOLE TIC TAC TOE"
    puts "********************************************************"
  end

  def game_start
    header
    while true
      puts "Would you like to play one player or two?"
      response = gets.chomp.to_i
      unless (1..2).include? response
        puts "sorry invalid response"
        next
      end
      game=Game.new(response)
      break
    end
  end

end
