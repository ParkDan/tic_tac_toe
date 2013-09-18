require './lib/tic_tac_toe'

describe VictoryConditions do
  before do
    $stdout.stub(:write)
    @test_game=TicTacToe.new
  end

end
