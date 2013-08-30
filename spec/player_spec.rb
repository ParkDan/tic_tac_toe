require './lib/player'

describe Player do
  it 'should set name attribute when created' do
    test_player=Player.new("dummy")
    expect(test_player.name).to eql("dummy")
  end
end

