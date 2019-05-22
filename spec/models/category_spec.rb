require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:category_games) }

  it { should validate_presence_of(:name) }
end
