require './lib/tic_tac_toe'

describe PlayerLogic do
  before do
    $stdout.stub(:write)
    @test_game=TicTacToe.new
    @valid_move_input="a3"
    @invalid_move_input="d5"
    @test_player=Player.new("dummy")
    @x_symbol="X"
  end

  describe 'turn' do
    it 'should incremenet count by 1 at end of turn' do
      pre_count=@test_game.count
      @test_game.stub(:gets).and_return("a3")
      @test_game.turn(@test_player, @x_symbol)
      post_count=@test_game.count
      expect(post_count).to eql(pre_count+1)
    end
    it 'should set winner to player name if game_victory_check is true' do
      @test_game.stub(:gets).and_return("a3")
      @test_game.stub(:game_victory_check).and_return(true)
      @test_game.turn(@test_player, @x_symbol)
      expect(@test_game.winner).to eql(@test_player.name.capitalize)
    end
  end

  describe 'turn_input_check' do
    it 'should return true for valid input for player turn' do
        move=@valid_move_input.split("")
        expect(@test_game.turn_input_check(move)).to be_true
    end
    it 'should return false for invalid input for player turn' do
        move=@invalid_move_input.split("")
        expect(@test_game.turn_input_check(move)).to be_false
    end
  end

  describe 'convert_turn_input' do
    it 'should convert input for player turn into valid array' do
        move=@valid_move_input.split("")
        expect(@test_game.convert_turn_input(move)).to eql([0,2])
    end
  end
end
