require './lib/board'
require './lib/computer'
require './lib/player'

class Game
  attr_reader :x_symbol, :o_symbol, :board

  def initialize
    @x_symbol = 'X'
    @o_symbol = 'O'
    @board = Board.new
  end

  def implement_interface(player_mode)
    one_player_interface if player_mode == 1
    two_player_interface if player_mode == 2
  end

  def one_player_interface
    level = set_computer_level
    order = set_first_move
    puts "What's your name?"
    name = gets.chomp.capitalize
    name = "Player" if name.empty?
    p1, p2 = Player.new(name, @x_symbol), Computer.new("Computer", level, @o_symbol, @x_symbol) if order == 1
    p1, p2 = Computer.new("Computer", level, @x_symbol, @o_symbol), Player.new(name, @o_symbol) if order == 2
    @board.example
    while @board.game_on?
      p1.turn(@board)
      break if @board.game_over?
      p2.turn(@board)
    end
    puts game_over_message
  end

  def two_player_interface
    puts "What's the name for player 1?"
    name = gets.chomp.capitalize
    name = "Player 1" if name.empty?
    p1 = Player.new(name, @x_symbol)
    puts "What's the name for player 2?"
    name = gets.chomp.capitalize
    name = "Player 2" if name.empty? || name == p1.name
    p2 = Player.new(name, @o_symbol)
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
    cpu1.stub(:sleep)
    cpu2.stub(:sleep)
    while @board.game_on?
      cpu1.turn(@board)
      break if @board.game_over?
      cpu2.turn(@board)
    end
    @board.winner
  end

  # private

  def set_computer_level
    5.times do
      puts "Please select computer level: 1(easy), 2(intermediate), 3(unbeatable)"
      level = gets.chomp.to_i
      return level if (1..3).include? level
    end
    level = rand(1..3)
  end

  def set_first_move
    5.times do
      puts "Would you like to go 1st or 2nd? (1,2)"
      order = gets.chomp.to_i
      return order if (1..2).include? order
    end
    order = rand(1..2)
  end

  def game_over_message
    return "You have reached a stalemate" if @board.stalemate?
    "The winner is #{@board.winner}!"
  end

end
