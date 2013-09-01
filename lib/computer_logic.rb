module ComputerLogic
  def computer_turn(player, symbol, level)
    puts "Computer turn..."
    # sleep 0.5
    move=computer_move(level, symbol)
    assign_move(move, symbol)
    if game_victory_check
      @winner=player.name.capitalize
    end
    @count+=1
  end

  def computer_move(level, symbol)
    move=[1,1]
    while true
      break if empty?(move)
      if level==1
        move=rand_move
      elsif level==2
        move=intermediate_move(symbol)
      else
        move=best_move(symbol)
      end
    end
    return move
  end

  def rand_move
    move=[]
    move[0]=rand(3)
    move[1]=rand(3)
    return move
  end

  def best_move(symbol)
    symbol2=(@symbol-[symbol]).first
    return two_in_a_row_case(symbol) if two_in_a_row_case(symbol)
    return two_in_a_row_case(symbol2) if two_in_a_row_case(symbol2)
    return special_case_for_fourth_turn(symbol2) if special_case_for_fourth_turn(symbol2)
    return next_move
  end

  def intermediate_move(symbol)
    symbol2=(@symbol-[symbol]).first
    return two_in_a_row_case(symbol) if two_in_a_row_case(symbol)
    return two_in_a_row_case(symbol2) if two_in_a_row_case(symbol2)
    return rand_move
  end
  def two_in_a_row_case(symbol)
    return [0,0] if ((@board[0][1]==@board[0][2]&&@board[0][1]==symbol)||(@board[1][0]==@board[2][0]&&@board[1][0]==symbol)||(@board[1][1]==@board[2][2]&&@board[1][1]==symbol))&&empty?([0,0])
    return [0,2] if ((@board[0][1]==@board[0][0]&&@board[0][1]==symbol)||(@board[1][2]==@board[2][2]&&@board[1][2]==symbol)||(@board[1][1]==@board[2][0]&&@board[1][1]==symbol))&&empty?([0,2])
    return [2,0] if ((@board[0][0]==@board[1][0]&&@board[0][0]==symbol)||(@board[2][1]==@board[2][2]&&@board[2][1]==symbol)||(@board[1][1]==@board[0][2]&&@board[1][1]==symbol))&&empty?([2,0])
    return [2,2] if ((@board[0][0]==@board[1][1]&&@board[0][0]==symbol)||(@board[0][2]==@board[1][2]&&@board[0][2]==symbol)||(@board[2][0]==@board[2][1]&&@board[2][0]==symbol))&&empty?([2,2])

    return [0,1] if ((@board[0][0]==@board[0][2]&&@board[0][0]==symbol)||(@board[1][1]==@board[2][1]&&@board[1][1]==symbol))&&empty?([0,1])
    return [1,0] if ((@board[1][1]==@board[1][2]&&@board[1][1]==symbol)||(@board[0][0]==@board[2][0]&&@board[0][0]==symbol))&&empty?([1,0])
    return [1,2] if ((@board[0][2]==@board[2][2]&&@board[0][2]==symbol)||(@board[1][0]==@board[1][1]&&@board[1][0]==symbol))&&empty?([1,2])
    return [2,1] if ((@board[2][0]==@board[2][2]&&@board[2][0]==symbol)||(@board[0][1]==@board[1][1]&&@board[0][1]==symbol))&&empty?([2,1])
  end

  def special_case_for_fourth_turn(symbol)
    return [2,2] if @board[2][1]==@board[1][2]&&@board[2][1]==symbol&&@count==3&&empty?([2,2])
    return [2,1] if @board[2][0]==@board[0][2]&&@board[2][0]==symbol||@board[0][0]==@board[2][2]&&@board[0][0]==symbol&&@count==3&&empty?([2,1])
    return [0,1] if @board[2][0]==@board[1][2]&&@board[2][0]==symbol||@board[2][1]==@board[0][2]&&@board[0][2]==symbol&&@count==3&&empty?([0,1])
  end

  def next_move
    return [0,0] if empty?([0,0])
    return [0,2] if empty?([0,2])
    return [2,0] if empty?([2,0])
    return [2,2] if empty?([2,2])

    return [0,1] if empty?([0,1])
    return [1,0] if empty?([1,0])
    return [1,2] if empty?([1,2])
    return [2,1] if empty?([2,1])
  end

end
