require './lib/board'

describe Board do
   describe 'initialization' do
    context 'when created' do
      it {expect(self).not_to eql(nil)}
      it {expect(subject.winner).to eql("")}
      it {expect(subject.count).to eql(0)}
      it {expect(subject.board).to be_an Array}
      it {expect(subject.board.count).to eql(3)}
      it {expect(subject.board.first.count).to eql(3)}
      it {expect(subject.board).to eql([subject.board.first]*3)}
    end
  end

  before do
    $stdout.stub(:write)
    @board = Board.new
    @valid_move = [1,1]
  end

  describe 'assign_move' do
    it 'should set value in board array with symbol' do
      symbol = "X"
      @board.assign_move(@valid_move, symbol)
      expect(@board.board[@valid_move[0]][@valid_move[1]]).to eql(symbol)
    end
  end

  describe 'empty?' do
    it 'should return true if move for board is empty' do
      expect(@board.empty?(@valid_move)).to be_true
    end

    it 'should return false if move for board is not empty' do
      @board.assign_move(@valid_move, "X")
      expect(@board.empty?(@valid_move)).to be_false
    end
  end

  describe 'game_over?' do
    it 'shoud return true if count = 9' do
      @board.count = 9
      expect(@board.game_over?).to be_true
    end
    it 'should return true if game_victory_check is true' do
      @board.stub(:game_victory_check).and_return(true)
      expect(@board.game_over?).to be_true
    end
  end

  describe 'game_on?' do
    it 'shoud return false if count = 9' do
      @board.count = 9
      expect(@board.game_on?).to be_false
    end
    it 'should return false if game_victory_check is true' do
      @board.stub(:game_victory_check).and_return(true)
      expect(@board.game_on?).to be_false
    end
  end

  describe 'game_victory_check' do
    it 'should return false if board does not have three in a row of a symbol' do
      expect(@board.game_victory_check).to be_false
    end
    it 'should return true if board has three in a row of a symbol' do
      move1 = [0,0]
      move2 = [0,1]
      move3 = [0,2]
      symbol = "X"
      @board.assign_move(move1, symbol)
      @board.assign_move(move2, symbol)
      @board.assign_move(move3, symbol)
      expect(@board.game_victory_check).to be_true
    end
  end
end
