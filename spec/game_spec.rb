require './lib/game'

describe Game do
  before do
    $stdout.stub(:write)
    @test_game = Game.new
  end

  describe 'initialization' do
    context 'when created' do
      it {expect(self).not_to eql(nil)}
      it {expect(subject.x_symbol).to eql('X')}
      it {expect(subject.o_symbol).to eql('O')}
      it {expect(subject.board).to be_a Board}
    end
  end

  describe 'game_over_message' do
    it 'should return tie message if count is 9 and no winner' do
      9.times { @test_game.board.add_count }
      tie_message = "You have reached a stalemate"
      expect(@test_game.game_over_message).to eql(tie_message)
    end
    it 'should return winner message if winner has been established' do
      @test_game.board.add_winner("Me")
      winner_message = "The winner is #{@test_game.board.winner}!"
      expect(@test_game.game_over_message).to eql(winner_message)
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
