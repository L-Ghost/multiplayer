require 'rails_helper'

RSpec.describe Platform, type: :model do
  it { should belong_to(:company) }
  it { should have_many(:game_releases) }

  it { should validate_presence_of(:name) }
end
