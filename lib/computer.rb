require './lib/position_constants'

class Computer
  include PositionConstants

  attr_reader :name, :level, :symbol

  def initialize(name, level, symbol, opponent_symbol)
    @name = name
    @level = level
    @symbol = symbol
    @opponent_symbol = opponent_symbol
  end

  def turn(board)
    puts "Computer turn..."
    sleep 0.5
    move = computer_move(board)
    board.assign_move(move, symbol)
    board.add_winner(@name) if board.game_victory_check
    board.add_count
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

  def best_move(board)
    return two_in_a_row_case(board, @symbol) if two_in_a_row_case(board, @symbol)
    return two_in_a_row_case(board, @opponent_symbol) if two_in_a_row_case(board, @opponent_symbol)
    return special_case_for_fourth_turn(board, @opponent_symbol) if special_case_for_fourth_turn(board, @opponent_symbol)
    next_move(board)
  end

  def intermediate_move(board)
    return two_in_a_row_case(board, @symbol) if two_in_a_row_case(board, @symbol)
    return two_in_a_row_case(board, @opponent_symbol) if two_in_a_row_case(board, @opponent_symbol)
    rand_move
  end

  def two_in_a_row_case(board, symbol)
    return TOP_LEFT if ((board.position(TOP_MID) == board.position(TOP_RIGHT) && board.position(TOP_MID) == symbol) || (board.position(MID_LEFT) == board.position(BOT_LEFT) && board.position(MID_LEFT) == symbol) || (board.position(CENTER) == board.position(BOT_RIGHT) && board.position(CENTER) == symbol)) && board.empty?(TOP_LEFT)
    return TOP_RIGHT if ((board.position(TOP_MID) == board.position(TOP_LEFT) && board.position(TOP_MID) == symbol) || (board.position(MID_RIGHT) == board.position(BOT_RIGHT) && board.position(MID_RIGHT) == symbol) || (board.position(CENTER) == board.position(BOT_LEFT) && board.position(CENTER) == symbol)) && board.empty?(TOP_RIGHT)
    return BOT_LEFT if ((board.position(TOP_LEFT) == board.position(MID_LEFT) && board.position(TOP_LEFT) == symbol) || (board.position(BOT_MID) == board.position(BOT_RIGHT) && board.position(BOT_MID) == symbol) || (board.position(CENTER) == board.position(TOP_RIGHT) && board.position(CENTER) == symbol)) && board.empty?(BOT_LEFT)
    return BOT_RIGHT if ((board.position(TOP_LEFT) == board.position(CENTER) && board.position(TOP_LEFT) == symbol) || (board.position(TOP_RIGHT) == board.position(MID_RIGHT) && board.position(TOP_RIGHT) == symbol) || (board.position(BOT_LEFT) == board.position(BOT_MID) && board.position(BOT_LEFT) == symbol)) && board.empty?(BOT_RIGHT)
    return TOP_MID if ((board.position(TOP_LEFT) == board.position(TOP_RIGHT) && board.position(TOP_LEFT) == symbol) || (board.position(CENTER) == board.position(BOT_MID) && board.position(CENTER) == symbol)) && board.empty?(TOP_MID)
    return MID_LEFT if ((board.position(CENTER) == board.position(MID_RIGHT) && board.position(CENTER) == symbol) || (board.position(TOP_LEFT) == board.position(BOT_LEFT) && board.position(TOP_LEFT) == symbol)) && board.empty?(MID_LEFT)
    return MID_RIGHT if ((board.position(TOP_RIGHT) == board.position(BOT_RIGHT) && board.position(TOP_RIGHT) == symbol) || (board.position(MID_LEFT) == board.position(CENTER) && board.position(MID_LEFT) == symbol)) && board.empty?(MID_RIGHT)
    return BOT_MID if ((board.position(BOT_LEFT) == board.position(BOT_RIGHT) && board.position(BOT_LEFT) == symbol) || (board.position(TOP_MID) == board.position(CENTER) && board.position(TOP_MID) == symbol)) && board.empty?(BOT_MID)
  end

  def special_case_for_fourth_turn(board, symbol)
    case1 = board.position(BOT_MID) == board.position(MID_RIGHT) && board.position(BOT_MID) == symbol
    case2 = board.position(BOT_LEFT) == board.position(MID_RIGHT) && board.position(BOT_LEFT) == symbol
    case3 = board.position(TOP_LEFT) == board.position(BOT_MID) && board.position(TOP_LEFT) == symbol
    case4 = board.position(BOT_MID) == board.position(TOP_RIGHT) && board.position(TOP_RIGHT) == symbol
    case5 = board.position(BOT_LEFT) == board.position(TOP_RIGHT) && board.position(BOT_LEFT) == symbol
    case6 = board.position(TOP_LEFT) == board.position(BOT_RIGHT) && board.position(TOP_LEFT) == symbol
    return BOT_RIGHT if (case1 || case2 || case3 || case4 && board.count == 3) && board.empty?(BOT_RIGHT)
    return BOT_MID if (case5 || case6 && board.count == 3) && board.empty?(BOT_MID)
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
