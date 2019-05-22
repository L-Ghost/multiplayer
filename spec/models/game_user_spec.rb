require 'rails_helper'

RSpec.describe GameUser, type: :model do
  it { should belong_to(:game) }
  it { should belong_to(:user) }
end
