require './lib/board'
require './lib/computer'
require './lib/player'

class Game
  attr_reader :x_symbol, :o_symbol, :board

  def initialize
    @x_symbol, @o_symbol, @board = 'X', 'O', Board.new
  end

  def implement_interface(player_mode)
    one_player_interface if player_mode == 1
    two_player_interface if player_mode == 2
  end

  def one_player_interface
    order = set_first_move
    p1, p2 = Player.new(get_name(order), @x_symbol), Computer.new("Computer", set_computer_level, @o_symbol, @x_symbol) if order == 1
    p1, p2 = Computer.new("Computer", set_computer_level, @x_symbol, @o_symbol), Player.new(get_name(order), @o_symbol) if order == 2
    run_game(p1, p2)
  end

  def two_player_interface
    p1, p2 = Player.new(get_name(1), @x_symbol), Player.new(get_name(2), @o_symbol)
    run_game(p1, p2)
  end

  def cpu_v_cpu_interface(level1, level2)
    p1, p2 = Computer.new("Computer1", level1, @x_symbol, @o_symbol), Computer.new("Computer2", level2, @o_symbol, @x_symbol)
    p1.stub(:sleep); p2.stub(:sleep)
    run_game(p1, p2)
  end

  # private

  def get_name(num)
    puts "What's the name for player #{num}?"
    name = gets.chomp.capitalize
    name = "Player #{num}" if name.empty?
    name
  end

  def run_game(p1, p2)
    @board.example
    while @board.game_on?
      p1.turn(@board)
      break if @board.game_over?
      p2.turn(@board)
    end
    puts game_over_message
  end

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
