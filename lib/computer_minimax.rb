require 'constants'
require 'io_interface'
require 'board'

class Computer
  include IOInterface
  include Constants

  attr_reader :name, :level, :symbol

  def initialize(name, level, symbol)
    @name, @level, @symbol = name, level, symbol
    @game_array=[]
    @game_state_array = []
  end

  def opp_symbol
    @symbol == X_SYM ? O_SYM : X_SYM
  end

  def turn(board)
    cpu_turn_output
    board.assign_move(computer_move(board), symbol)
    board.add_winner(@name) if board.game_victory_check
  end

  # private

  def computer_move(board)
    move = rand_move(board) if @level == 1
    move = best_move(board, @symbol) if @level == 3
    move
  end

  def rand_move(board) move = board.available_moves.sample end

  def best_move(board, symbol)
    gamestate = GameState.new(board)
    board.available_moves.each { |pos| game_tree(board, pos, symbol, gamestate) }
    max_pos(gamestate.optimal_pos_hash)
  end

  def game_tree(board, first_pos, symbol, gamestate)
    board.available_moves.each do |pos|
    temp_board=board
      while temp_board.game_on?
        next unless temp_board.empty?(pos)
        temp_board.assign_move(pos, symbol)
        temp_board.add_winner(symbol) if temp_board.game_victory_check
        break if temp_board.game_over?
        opp_move(temp_board)
      end
      gamestate.optimal_pos_hash[first_pos] += 1 if temp_board.winner == @symbol
      gamestate.optimal_pos_hash[first_pos] -= 1 if temp_board.winner == opp_symbol
      @game_array << temp_board
    end
    @game_state_array << gamestate
  end

  def max_pos(pos_hash) pos_hash.max_by{|k,v| v}.first end

  def opp_move(board)
    board.stub(:display)
    board.assign_move(best_move(board, opp_symbol), opp_symbol)
  end

end

class GameState
  include Constants
  attr_accessor :optimal_pos_hash, :state
  def initialize(board)
    @optimal_pos_hash={}
    POS_ARY.each { |pos| @optimal_pos_hash[pos] = 0 }
    @state = board.available_moves.count
  end
end
