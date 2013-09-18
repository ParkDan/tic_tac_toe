require './lib/tic_tac_toe'

describe BoardLogic do
  before do
    $stdout.stub(:write)
    @test_game=TicTacToe.new
    @test_game.stub(:game_victory_check).and_return(true)
    @valid_move=[1,1]
  end
    describe 'assign_move' do
      it 'should set value in board array with symbol' do
        symbol="$"
        @test_game.assign_move(@valid_move, symbol)
        expect(@test_game.board[@valid_move[0]][@valid_move[1]]).to eql(symbol)
      end
    end
    describe 'empty?' do
      it 'should return true if move for board is empty' do
        expect(@test_game.empty?(@valid_move)).to be_true
      end

      it 'should return false if move for board is not empty' do
        @test_game.assign_move(@valid_move, "X")
        expect(@test_game.empty?(@valid_move)).to be_false
      end
    end
    describe 'game_over?' do
      it 'shoud return true if count = 9' do
        @test_game.count=9
        expect(@test_game.game_over?).to be_true
      end
      it 'should return true if game_victory_check is true' do
        expect(@test_game.game_over?).to be_true
      end
    end
    describe 'game_on?' do
      it 'shoud return false if count = 9' do
        @test_game.count=9
        expect(@test_game.game_on?).to be_false
      end
      it 'should return false if game_victory_check is true' do
        expect(@test_game.game_on?).to be_false
      end
    end
end
