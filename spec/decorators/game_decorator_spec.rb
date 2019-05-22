require 'rails_helper'

RSpec.describe GameDecorator do
  let(:game) { create(:game).decorate }

  describe '#add_to_profile' do
    it 'shows link to add game to user profile' do
      regex = %r{href=\"\/games\/#{game.id}\/add\"}
      expect(game.add_to_profile).to match(regex)
    end

    it 'shows id equals to current game' do
      id = game.id + 1
      regex = %r{href=\"\/games\/#{id}\/add\"}
      expect(game.add_to_profile).not_to match(regex)
    end
  end
end
