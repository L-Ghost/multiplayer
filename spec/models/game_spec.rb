require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:game_categorizations) }
  it { should have_many(:game_releases) }
  it { should have_many(:game_users) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:release_year) }
  it { should validate_numericality_of(:release_year) }
end
