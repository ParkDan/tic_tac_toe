require './lib/board'
require './lib/computer'
require './lib/player'

class Game
  def initialize(player_mode)
    @x_symbol = 'X'
    @o_symbol = 'O'
    @board = Board.new
    implement_interface(player_mode)
  end

  def implement_interface(player_mode)
    one_player_interface if player_mode==1
    two_player_interface if player_mode==2
  end

  def one_player_interface
    level = set_computer_level
    order = set_first_move
    puts "What's your name?"
    name=gets.chomp.capitalize
    if order == 1
      p1=Player.new(name, @x_symbol)
      p2=Computer.new("Computer", level, @o_symbol, @x_symbol)
    else
      p1=Computer.new("Computer", level, @x_symbol, @o_symbol)
      p2=Player.new(name, @o_symbol)
    end
    @board.example
    while @board.game_on?
        p1.turn(@board)
        puts @board.count
        break if @board.game_over?
        p2.turn(@board)
        puts @board.count
    end
    puts game_over_message
  end

  def set_first_move
    while true
      puts "Would you like to go 1st or 2nd? (1,2)"
      order = gets.chomp.to_i
      break if (1..2).include? order
    end
    order
  end

  def set_computer_level
    while true
      puts "Please select computer level: 1(easy), 2(intermediate), 3(unbeatable)"
      level = gets.chomp.to_i
      break if (1..3).include? level
    end
    level
  end

  def two_player_interface
    puts "What's the name for player 1?"
    p1 = Player.new(gets.chomp.capitalize, @x_symbol)
    puts "What's the name for player 2?"
    p2 = Player.new(gets.chomp.capitalize, @o_symbol)
    @board.example
    while @board.game_on?
      p1.turn(@board)
      break if @board.game_over?
      p2.turn(@board)
    end
    puts game_over_message
  end

  def cpu_v_cpu_interface(level1, level2)
    cpu1=Computer.new("Computer1", level1, @x_symbol, @o_symbol)
    cpu2=Computer.new("Computer2", level2, @o_symbol, @x_symbol)
    while @board.game_on?
      cpu1.turn(@board)
      break if @board.game_over?
      cpu2.turn(@board)
    end
    @board.winner
  end

  def game_over_message
     if @board.count == 9 && @board.winner == ""
      return "You have reached a stalemate"
    else
      return "The winner is #{@board.winner}!"
    end
  end



end
