require_relative 'board'
require_relative 'computer'
require_relative 'player'
require_relative 'constants'
require_relative 'io_interface'

class Game
  include IOInterface
  include Constants
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def game_start
    header
    5.times do
      one_two_prompt
      response = get_response.to_i
      unless (1..2).include? response
        invalid
        next
      end
      implement_interface(response)
      break
    end
    goodbye
  end

  def implement_interface(player_mode) player_mode == 1 ? one_player_interface : two_player_interface end

  def one_player_interface
    order = set_first_move
    p1 = order == 1 ? Player.new(get_name(order), X_SYM) : Computer.new("Computer", set_computer_level, X_SYM)
    p2 = order == 2 ? Player.new(get_name(order), O_SYM) : Computer.new("Computer", set_computer_level, O_SYM)
    run_game(p1, p2)
  end

  def two_player_interface
    p1, p2 = Player.new(get_name(1), X_SYM), Player.new(get_name(2), O_SYM)
    run_game(p1, p2)
  end

  def cpu_v_cpu_interface(level1, level2)
    p1, p2 = Computer.new("Computer1", level1, X_SYM), Computer.new("Computer2", level2, O_SYM)
    p1.stub(:sleep); p2.stub(:sleep)
    run_game(p1, p2)
  end

  # private

  def get_name(num)
    name_prompt(num)
    name = get_response.capitalize
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
    game_over_message(@board)
  end

  def set_computer_level
    5.times do
      cpu_level_prompt
      level = get_response.to_i
      return level if (1..3).include? level
    end
    level = rand(1..3)
  end

  def set_first_move
    5.times do
      order_prompt
      order = get_response.to_i
      return order if (1..2).include? order
    end
    order = rand(1..2)
  end


end
