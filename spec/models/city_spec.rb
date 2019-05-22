require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:state) }

  it { should validate_presence_of(:name) }
end
