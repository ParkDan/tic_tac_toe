require './lib/player'

describe Player do
  before do
    $stdout.stub(:write)
    @test_board = Board.new
    @valid_move_input = "a3"
    @invalid_move_input = "d5"
    @test_name = "dummy"
    @test_symbol = "X"
    @test_player = Player.new(@test_name, @test_symbol)

  end

  it 'should set name attribute when created' do
    expect(@test_player.name).to eql(@test_name)
  end

  it 'should set symbol attribute when created' do
    expect(@test_player.symbol).to eql(@test_symbol)
  end

  describe 'turn' do
    it 'should incremenet count by 1 at end of turn' do
      pre_count = @test_board.count
      @test_player.stub(:gets).and_return(@valid_move_input)
      @test_player.turn(@test_board)
      post_count = @test_board.count
      expect(post_count).to eql(pre_count+1)
    end

    it 'should set winner name when player gets three of a kind' do
      @test_player.stub(:gets).and_return(@valid_move_input)
      @test_player.turn(@test_board)
      move1, move2 = "a1", "a2"
      @test_player.stub(:gets).and_return(move1)
      @test_player.turn(@test_board)
      @test_player.stub(:gets).and_return(move2)
      @test_player.turn(@test_board)
      expect(@test_board.winner).to eql(@test_player.name)
    end
  end

  describe 'turn_input_check' do
    it 'should return true for valid input for player turn' do
        move = @valid_move_input.split("")
        expect(@test_player.turn_input_check(move)).to be_true
    end
    it 'should return false for invalid input for player turn' do
        move = @invalid_move_input.split("")
        expect(@test_player.turn_input_check(move)).to be_false
    end
  end

  describe 'convert_turn_input' do
    it 'should convert input for player turn into valid array' do
        move = @valid_move_input.split("")
        expect(@test_player.convert_turn_input(move)).to eql([0,2])
    end
  end
end

