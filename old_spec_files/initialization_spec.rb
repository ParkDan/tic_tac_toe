require './lib/tic_tac_toe'

describe TicTacToe do
  describe 'initialization' do
    context 'when created' do
      it {expect(self).not_to eql(nil)}
      it {expect(subject.winner).to eql("")}
      it {expect(subject.count).to eql(0)}
      it {expect(subject.symbol).to be_an Array}
      it {expect(subject.symbol.count).to eql(2)}
      it {expect(subject.board).to be_an Array}
      it {expect(subject.board.count).to eql(3)}
      it {expect(subject.board.first.count).to eql(3)}
      it {expect(subject.board).to eql([subject.board.first]*3)}
    end
  end
end
