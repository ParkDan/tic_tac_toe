class Computer
  attr_accessor :name, :level, :symbol
  def initialize(name, level, symbol, opponent_symbol)
    @name = name
    @level = level
    @symbol = symbol
    @opponent_symbol = opponent_symbol
  end

  def turn(board)
    puts "Computer turn..."
    # sleep 0.5
    move = computer_move(board)
    board.assign_move(move, symbol)
    board.winner = @name if board.game_victory_check
    board.count += 1
  end

  def computer_move(board)
    move = [1,1]
    while board.game_on?
      break if board.empty?(move)
      if @level == 1
        move = rand_move
      elsif @level == 2
        move = intermediate_move(board)
      else
        move = best_move(board)
      end
    end
    move
  end

  def rand_move
    move = []
    move[0] = rand(3)
    move[1] = rand(3)
    move
  end

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
    return [0,0] if ((board.board[0][1] == board.board[0][2] && board.board[0][1] == symbol) || (board.board[1][0] == board.board[2][0] && board.board[1][0] == symbol) || (board.board[1][1] == board.board[2][2] && board.board[1][1] == symbol)) && board.empty?([0,0])
    return [0,2] if ((board.board[0][1] == board.board[0][0] && board.board[0][1] == symbol) || (board.board[1][2] == board.board[2][2] && board.board[1][2] == symbol) || (board.board[1][1] == board.board[2][0] && board.board[1][1] == symbol)) && board.empty?([0,2])
    return [2,0] if ((board.board[0][0] == board.board[1][0] && board.board[0][0] == symbol) || (board.board[2][1] == board.board[2][2] && board.board[2][1] == symbol) || (board.board[1][1] == board.board[0][2] && board.board[1][1] == symbol)) && board.empty?([2,0])
    return [2,2] if ((board.board[0][0] == board.board[1][1] && board.board[0][0] == symbol) || (board.board[0][2] == board.board[1][2] && board.board[0][2] == symbol) || (board.board[2][0] == board.board[2][1] && board.board[2][0] == symbol)) && board.empty?([2,2])
    return [0,1] if ((board.board[0][0] == board.board[0][2] && board.board[0][0] == symbol) || (board.board[1][1] == board.board[2][1] && board.board[1][1] == symbol)) && board.empty?([0,1])
    return [1,0] if ((board.board[1][1] == board.board[1][2] && board.board[1][1] == symbol) || (board.board[0][0] == board.board[2][0] && board.board[0][0] == symbol)) && board.empty?([1,0])
    return [1,2] if ((board.board[0][2] == board.board[2][2] && board.board[0][2] == symbol) || (board.board[1][0] == board.board[1][1] && board.board[1][0] == symbol)) && board.empty?([1,2])
    return [2,1] if ((board.board[2][0] == board.board[2][2] && board.board[2][0] == symbol) || (board.board[0][1] == board.board[1][1] && board.board[0][1] == symbol)) && board.empty?([2,1])
  end

  def special_case_for_fourth_turn(board, symbol)
    case1 = board.board[2][1] == board.board[1][2] && board.board[2][1] == symbol
    case2 = board.board[2][0] == board.board[1][2] && board.board[2][0] == symbol
    case3 = board.board[0][0] == board.board[2][1] && board.board[0][0] == symbol
    case4 = board.board[2][1] == board.board[0][2] && board.board[0][2] == symbol
    case5 = board.board[2][0] == board.board[0][2] && board.board[2][0] == symbol
    case6 = board.board[0][0] == board.board[2][2] && board.board[0][0] == symbol
    return [2,2] if (case1 || case2 || case3 || case4 && board.count == 3) && board.empty?([2,2])
    return [2,1] if (case5 || case6 && board.count == 3) && board.empty?([2,1])
  end

  def next_move(board)
    return [0,0] if board.empty?([0,0])
    return [0,2] if board.empty?([0,2])
    return [2,0] if board.empty?([2,0])
    return [2,2] if board.empty?([2,2])

    return [0,1] if board.empty?([0,1])
    return [1,0] if board.empty?([1,0])
    return [1,2] if board.empty?([1,2])
    return [2,1] if board.empty?([2,1])
  end

end
