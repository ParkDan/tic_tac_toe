require './lib/tic_tac_toe'

describe VictoryConditions do
  before do
    $stdout.stub(:write)
    @test_game=TicTacToe.new
  end
  describe 'game_victory_check' do
    it 'should return false if board does not have three in a row of a symbol' do
      expect(@test_game.game_victory_check).to be_false
    end
    it 'should return true if board has three in a row of a symbol' do
      move1=[0,0]
      move2=[0,1]
      move3=[0,2]
      symbol="X"
      @test_game.assign_move(move1, symbol)
      @test_game.assign_move(move2, symbol)
      @test_game.assign_move(move3, symbol)
      expect(@test_game.game_victory_check).to be_true
    end
  end
end
