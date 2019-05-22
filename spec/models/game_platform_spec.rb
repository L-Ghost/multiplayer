require 'rails_helper'

RSpec.describe GamePlatform, type: :model do
  it { should belong_to(:game) }
  it { should belong_to(:platform) }

  describe '#game_and_platform' do
    it 'should show names of game and platform' do
      game = create(:game, name: 'Battletoads')
      platform = create(:platform, name: 'Nintendo')
      gp = create(:game_platform, game: game, platform: platform)

      expect(gp.game_and_platform).to eq("#{game.name} - #{platform.name}")
    end
  end
end
