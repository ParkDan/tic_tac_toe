require './lib/computer'

describe Computer do
  before do
    $stdout.stub(:write)
    @test_board = Board.new
    @X_symbol = "X"
    @O_symbol = "O"
    @test_cpu = Computer.new("test", 1, @X_symbol, @O_symbol )
    @test_cpu.stub(:sleep)
    @center_move = [1,1]
  end

  describe 'rand_move' do
    it 'should return a random move that is valid' do
      test_move = @test_cpu.rand_move
      expect(0..2).to cover test_move[0]
      expect(0..2).to cover test_move[1]
    end
  end

  describe 'two_in_a_row_case' do
    it 'should return move to block case with two in a row of a symbol' do
      move1 = [0,0]
      move2 = [0,1]
      move3 = [0,2]
      @test_board.assign_move(move1, @X_symbol)
      @test_board.assign_move(move2, @X_symbol)
      expect(@test_cpu.two_in_a_row_case(@test_board, @X_symbol)).to eql(move3)
    end
  end

  describe 'next_move' do
    it 'should return a valid empty move systematically starting with corner moves' do
      TOP_LEFT_move = [0,0]
      expect(@test_cpu.next_move(@test_board)).to eql(TOP_LEFT_move)
    end
  end

  describe 'turn' do
    it 'should incremenet count by 1 at end of turn' do
      pre_count = @test_board.count
      @test_cpu.turn(@test_board)
      post_count = @test_board.count
      expect(post_count).to eql(pre_count+1)
    end
  end

  describe 'comupter_move' do
    it 'should return a center move if empty and valid parameters are passed' do
      expect(@test_cpu.computer_move(@test_board)).to eql(@center_move)
    end
    it 'should return a random move if level is set to 1 and center move is taken' do
      @test_board.assign_move(@center_move, @X_symbol)
      rand_move = [0,1]
      @test_cpu.stub(:rand_move).and_return(rand_move)
      expect(@test_cpu.computer_move(@test_board)).to eql(rand_move)
    end
    it 'should return an intermediate move if level is set to 2 and center move is taken' do
      @test_cpu = Computer.new("test", 2, @X_symbol, @O_symbol )
      @test_board.assign_move(@center_move, @X_symbol)
      intermediate_move = [0,2]
      @test_cpu.stub(:intermediate_move).and_return(intermediate_move)
      expect(@test_cpu.computer_move(@test_board)).to eql(intermediate_move)
    end
    it 'should return a best move if level is set to 3 and center move is taken' do
      @test_cpu = Computer.new("test", 3, @X_symbol, @O_symbol )
      @test_board.assign_move(@center_move, @X_symbol)
      best_move = [0,0]
      @test_cpu.stub(:best_move).and_return(best_move)
      expect(@test_cpu.computer_move(@test_board)).to eql(best_move)
    end
  end
end
