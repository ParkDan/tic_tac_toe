module VictoryConditions
    def game_victory_check
    return true if @board[0][0]==@board[0][1]&&@board[0][1]==@board[0][2]&&!empty?([0,2])
    return true if @board[1][0]==@board[1][1]&&@board[1][1]==@board[1][2]&&!empty?([1,2])
    return true if @board[2][0]==@board[2][1]&&@board[2][1]==@board[2][2]&&!empty?([2,2])

    return true if @board[0][0]==@board[1][0]&&@board[1][0]==@board[2][0]&&!empty?([2,0])
    return true if @board[0][1]==@board[1][1]&&@board[1][1]==@board[2][1]&&!empty?([2,1])
    return true if @board[0][2]==@board[1][2]&&@board[1][2]==@board[2][2]&&!empty?([2,2])

    return true if @board[0][0]==@board[1][1]&&@board[1][1]==@board[2][2]&&!empty?([2,2])
    return true if @board[2][0]==@board[1][1]&&@board[1][1]==@board[0][2]&&!empty?([0,2])

    return false
  end
end
