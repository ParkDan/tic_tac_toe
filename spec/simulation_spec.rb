require './lib/game'

describe '100X cpu vs cpu simulation tests' do
  before do
    $stdout.stub(:write)
  end

  it 'should only allow stalemate for 100 games of unbeatable cpu vs unbeatable cpu' do
    game_over_array = []
    100.times do |x|
      test_game = Game.new
      game_over_array << test_game.cpu_v_cpu_interface(3, 3)
    end
    expect(game_over_array).not_to include "Computer1, Computer2"
  end

  describe '100x random cpu vs unbeatable cpu tests'
  before do
    @game_over_array = []
    @count_array = []
    @board_array = []
    100.times do |x|
      test_game = Game.new
      @game_over_array << test_game.cpu_v_cpu_interface(1, 3)
      @count_array << test_game.board.count
      @board_array << test_game.board.board
    end
  end

  it 'shoud never allow random cpu to win for 100 games of random cpu vs unbeatable cpu' do
    expect(@game_over_array.join).not_to include "Computer1"
  end

  it 'should never have a count greater than 9' do
    @count_array.each{|count| expect(count).to be < 10}
  end

  it 'should check if board has nine objects' do
    @board_array.each{|board| expect(board.flatten).to have(9).things}
  end

  it 'should check if board contains X, and O symbols' do
    @board_array.each{|board| expect(board.flatten).to include 'X', 'O'}
  end
end
