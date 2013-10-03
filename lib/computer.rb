require 'constants'
require 'io_interface'

class Computer
  include IOInterface
  include Constants

  attr_reader :name, :level, :symbol

  def initialize(name, level, symbol)
    @name, @level, @symbol = name, level, symbol
  end

  def opp_symbol
    @symbol == X_SYM ? O_SYM : X_SYM
  end

  def turn(board)
    cpu_turn_output
    sleep 0.5
    board.assign_move(computer_move(board), symbol)
    board.add_winner(@name) if board.game_victory_check
  end

  # private

  def computer_move(board)
    move = CENTER
    while board.game_on?
      break if board.empty?(move)
      move = rand_move if @level == 1
      move = intermediate_move(board) if @level == 2
      move = best_move(board) if @level == 3
    end
    move
  end

  def rand_move() move = [rand(3), rand(3)] end

  def intermediate_move(board) two_in_a_row_case(board, @symbol) || two_in_a_row_case(board, opp_symbol) || rand_move end

  def best_move(board) two_in_a_row_case(board, @symbol) || two_in_a_row_case(board, opp_symbol) || special_case_for_fourth_turn(board, opp_symbol) || next_move(board) end

  def two_in_a_row_case(board, symbol)
    return TOP_LEFT if board.empty?(TOP_LEFT) && (board.p_eql?(TOP_MID, TOP_RIGHT, symbol) || board.p_eql?(MID_LEFT, BOT_LEFT, symbol) || board.p_eql?(CENTER, BOT_RIGHT, symbol))
    return TOP_RIGHT if board.empty?(TOP_RIGHT) && (board.p_eql?(TOP_MID, TOP_LEFT, symbol) || board.p_eql?(MID_RIGHT, BOT_RIGHT, symbol) || board.p_eql?(CENTER, BOT_LEFT, symbol))
    return BOT_LEFT if board.empty?(BOT_LEFT) && (board.p_eql?(TOP_LEFT, MID_LEFT, symbol) || board.p_eql?(BOT_MID, BOT_RIGHT, symbol) || board.p_eql?(CENTER, TOP_RIGHT, symbol))
    return BOT_RIGHT if board.empty?(BOT_RIGHT) && (board.p_eql?(TOP_LEFT, CENTER, symbol) || board.p_eql?(TOP_RIGHT, MID_RIGHT, symbol) || board.p_eql?(BOT_LEFT, BOT_MID, symbol))
    return TOP_MID if board.empty?(TOP_MID) && (board.p_eql?(TOP_LEFT, TOP_RIGHT, symbol) || board.p_eql?(CENTER, BOT_MID, symbol))
    return MID_LEFT if board.empty?(MID_LEFT) && (board.p_eql?(CENTER, MID_RIGHT, symbol) || board.p_eql?(TOP_LEFT, BOT_LEFT, symbol))
    return MID_RIGHT if board.empty?(MID_RIGHT) && (board.p_eql?(TOP_RIGHT, BOT_RIGHT, symbol) || board.p_eql?(MID_LEFT, CENTER, symbol))
    return BOT_MID if board.empty?(BOT_MID) && (board.p_eql?(BOT_LEFT, BOT_RIGHT, symbol) || board.p_eql?(TOP_MID, CENTER, symbol))
  end

  def special_case_for_fourth_turn(board, opp_symbol)
    case1 = board.p_eql?(BOT_MID, MID_RIGHT, opp_symbol)
    case2 = board.p_eql?(BOT_LEFT, MID_RIGHT, opp_symbol)
    case3 = board.p_eql?(TOP_LEFT, BOT_MID, opp_symbol)
    case4 = board.p_eql?(BOT_MID, TOP_RIGHT, opp_symbol)
    case5 = board.p_eql?(BOT_LEFT, TOP_RIGHT, opp_symbol)
    case6 = board.p_eql?(TOP_LEFT, BOT_RIGHT, opp_symbol)
    return BOT_RIGHT if board.empty?(BOT_RIGHT) && board.count == 3 && (case1 || case2 || case3 || case4)
    return BOT_MID if board.empty?(BOT_MID) && board.count == 3 && (case5 || case6)
  end

  def next_move(board)
    return TOP_LEFT if board.empty? TOP_LEFT
    return TOP_RIGHT if board.empty? TOP_RIGHT
    return BOT_LEFT if board.empty? BOT_LEFT
    return BOT_RIGHT if board.empty? BOT_RIGHT

    return TOP_MID if board.empty? TOP_MID
    return MID_LEFT if board.empty? MID_LEFT
    return MID_RIGHT if board.empty? MID_RIGHT
    return BOT_MID if board.empty? BOT_MID
  end
end
