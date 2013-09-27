require 'game'

describe Game do
  before do
    $stdout.stub(:write)
    @test_game = Game.new
  end

  describe 'initialization' do
    context 'when created' do
      it {expect(self).not_to eql(nil)}
      it {expect(subject.board).to be_a Board}
    end
  end

  describe 'set_first_move' do
    it 'returns 1 or 2 depending on user input' do
      @test_game.stub(:gets).and_return("1")
      expect(@test_game.set_first_move).to eql(1)
    end
  end

  describe 'set_computer_level' do
    it 'returns 1, 2, 3 depending on user input' do
      @test_game.stub(:gets).and_return("1")
      expect(@test_game.set_computer_level).to eql(1)
    end
  end
end
