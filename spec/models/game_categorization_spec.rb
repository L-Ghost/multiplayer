require 'rails_helper'

RSpec.describe GameCategorization, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:game) }
end
