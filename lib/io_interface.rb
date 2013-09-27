module IOInterface
  def get_response() gets.chomp end

  def header
    puts "********************************************************"
    puts "WELCOME TO CONSOLE TIC TAC TOE"
    puts "********************************************************"
  end

  def one_two_prompt() puts "Would you like to play one player or two? (1 or 2)" end

  def invalid() puts "Sorry that was an invalid response" end

  def goodbye
    puts "********************************************************"
    puts "GoodBye"
  end

  def instructions() puts "Please use a-c to refer to rows and 1-3 to refer to columns (e.g a2)" end

  def display_output
    puts "   1   2   3 "
    puts "a  #{yield 0} | #{yield 1} | #{yield 2}  "
    puts "  ___|___|___"
    puts "b  #{yield 3} | #{yield 4} | #{yield 5}  "
    puts "  ___|___|___"
    puts "c  #{yield 6} | #{yield 7} | #{yield 8}  "
    puts "     |   |   "
    puts "********************************************************"
  end

  def name_prompt(num) puts "What's the name for player #{num}?" end

  def cpu_turn_output() puts "Computer turn..." end

  def cpu_level_prompt() puts "Please select computer level: 1(easy), 2(intermediate), 3(unbeatable)" end

  def order_prompt() puts "Would you like to go 1st or 2nd? (1,2)" end

  def turn_prompt(name) puts "#{name}, please take your turn" end

  def game_over_message(board)
    return "You have reached a stalemate" if board.stalemate?
    "The winner is #{board.winner}!"
  end
end
