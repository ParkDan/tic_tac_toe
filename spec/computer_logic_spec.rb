require './lib/tic_tac_toe'

describe ComputerLogic do
  before do
    $stdout.stub(:write)
    @test_game=TicTacToe.new
    @X_symbol="X"
    @player=Player.new('test_computer')
    @level_array=[1,2,3]
    @center_move=[1,1]
  end

  describe 'rand_move' do
    it 'should return a random move that is valid' do
      test_move=@test_game.rand_move
      expect(0..2).to cover test_move[0]
      expect(0..2).to cover test_move[1]
    end
  end

  describe 'two_in_a_row_case' do
    it 'should return move to block case with two in a row of a symbol' do
      move1=[0,0]
      move2=[0,1]
      move3=[0,2]
      @test_game.assign_move(move1, @X_symbol)
      @test_game.assign_move(move2, @X_symbol)
      expect(@test_game.two_in_a_row_case(@X_symbol)).to eql(move3)
    end
  end

  describe 'next_move' do
    it 'should return a valid empty move systematically starting with corner moves' do
      top_left_move=[0,0]
      expect(@test_game.next_move).to eql(top_left_move)
    end
  end

  describe 'computer_turn' do
    it 'should incremenet count by 1 at end of turn' do
      pre_count=@test_game.count
      @test_game.computer_turn(@player, @X_symbol, @level_array[0])
      post_count=@test_game.count
      expect(post_count).to eql(pre_count+1)
    end
  end

  describe 'comupter_move' do
    it 'should return a center move if empty and valid parameters are passed' do
      expect(@test_game.computer_move(@level_array[0], @X_symbol)).to eql(@center_move)
    end
    it 'should return a random move if level is set to 1 and center move is taken' do
      @test_game.assign_move(@center_move, @X_symbol)
      rand_move=[0,1]
      @test_game.stub(:rand_move).and_return(rand_move)
      expect(@test_game.computer_move(@level_array[0], @X_symbol)).to eql(rand_move)
    end
    it 'should return an intermediate move if level is set to 2 and center move is taken' do
      @test_game.assign_move(@center_move, @X_symbol)
      intermediate_move=[0,2]
      @test_game.stub(:intermediate_move).and_return(intermediate_move)
      expect(@test_game.computer_move(@level_array[1], @X_symbol)).to eql(intermediate_move)
    end
    it 'should return a best move if level is set to 3 and center move is taken' do
      @test_game.assign_move(@center_move, @X_symbol)
      best_move=[0,0]
      @test_game.stub(:best_move).and_return(best_move)
      expect(@test_game.computer_move(@level_array[2], @X_symbol)).to eql(best_move)
    end
  end

end
