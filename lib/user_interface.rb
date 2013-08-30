module UserInterface
  def one_player_interface
    puts "What's your name?"
    p1=Player.new(gets.chomp.capitalize)
    p2=Player.new("computer")
    level=set_computer_level
    order=set_first_move
    example
    while game_on?
      if order==1
        turn(p1, @symbol[0])
        break if game_over?
        computer_turn(p2, @symbol[1], level)
      else
        computer_turn(p2, @symbol[0], level)
        break if game_over?
        turn(p1, @symbol[1])
      end
    end
    puts game_over_message
  end

  def set_first_move
    while true
      puts "Would you like to go 1st or 2nd? (1,2)"
      order=gets.chomp.to_i
      break if (1..2).include? order
    end
    return order
  end

  def set_computer_level
    while true
      puts "Please select computer level: 1(easy), 2(intermediate), 3(unbeatable)"
      level=gets.chomp.to_i
      break if (1..3).include? level
    end
    return level
  end

  def two_player_interface
    puts "What's the name for player 1?"
    p1=Player.new(gets.chomp.capitalize)
    puts "What's the name for player 2?"
    p2=Player.new(gets.chomp.capitalize)
    example
    while game_on?
      turn(p1, @symbol[0])
      break if game_over?
      turn(p2, @symbol[1])
    end
    puts game_over_message
  end

  def cpu_v_cpu(level1, level2)
    p1=Player.new("computer1")
    p2=Player.new("computer2")
    while game_on?
      computer_turn(p1, @symbol[0], level1)
      break if game_over?
      computer_turn(p2, @symbol[1], level2)
    end
    @winner
  end

  def game_over_message
     if @count== 9 && @winner==""
      return "You have reached a stalemate"
    else
      return "The winner is #{@winner}!"
    end
  end

  def header
    puts "********************************************************"
    puts "WELCOME TO CONSOLE TIC TAC TOE"
    puts "********************************************************"
  end

  def game_start
    header
    while true
      puts "Would you like to play one player or two?"
      response=gets.chomp.to_i
      if response==2
        two_player_interface
        break
      elsif response==1
        one_player_interface
        break
      else
        puts "sorry invalid response"
      end
    end
  end
end
