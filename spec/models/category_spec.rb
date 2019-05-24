require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:game_categorizations) }

  it { should validate_presence_of(:name) }
end
