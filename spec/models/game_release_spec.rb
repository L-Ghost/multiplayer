require 'rails_helper'

RSpec.describe GameRelease, type: :model do
  it { should belong_to(:game) }
  it { should belong_to(:platform) }

  describe '#game_and_platform' do
    it 'should show names of game and platform' do
      game = build(:game, name: 'Battletoads')
      platform = build(:platform, name: 'Nintendo')
      gr = build(:game_release, game: game, platform: platform)

      expect(gr.game_and_platform).to eq("#{game.name} - #{platform.name}")
    end
  end
end
