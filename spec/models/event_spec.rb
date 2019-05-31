require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game_release) }
  it { should have_many(:event_invites) }
  it { should have_many(:event_requests) }
  it { should have_many(:event_participations) }

  it { should define_enum_for(:event_type) }

  describe '#total_participants' do
    let(:event) { create(:event) }

    it 'counts number of participants' do
      create_list(:event_participation, 2, event: event)

      expect(event.total_participants).to eq(2)
    end

    it 'count results in zero' do
      expect(event.total_participants).to eq(0)
    end
  end

  describe '#full?' do
    it 'is full' do
      event = create(:event, user_limit: 5)
      create_list(:event_participation, 5, event: event)

      expect(event.full?).to be_truthy
    end

    it 'is not full' do
      event = create(:event, user_limit: 5)
      create_list(:event_participation, 3, event: event)

      expect(event.full?).to be_falsy
    end
  end

  describe '#owner?' do
    let(:user) { build(:user) }

    it 'is current user' do
      event = build(:event, user: user)

      expect(event.owner?(user)).to be_truthy
    end

    it 'is not current user' do
      event = build(:event)

      expect(event.owner?(user)).to be_falsy
    end
  end

  describe '#requested_by?' do
    let(:user) { create(:user) }

    it 'current user' do
      event = create(:event)
      create(:event_request, event: event, user: user)

      expect(event.requested_by?(user)).to be_truthy
    end

    it 'not the current user' do
      event = create(:event)

      expect(event.requested_by?(user)).to be_falsy
    end
  end

  describe '#invite_for?' do
    let(:user) { create(:user) }

    it 'current user' do
      event = create(:event)
      create(:event_invite, event: event, invitee: user)

      expect(event.invite_for?(user)).to be_truthy
    end

    it 'not the current user' do
      event = create(:event)

      expect(event.invite_for?(user)).to be_falsy
    end
  end

  describe '#participant?' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    it 'is participating' do
      create(:event_participation, event: event, user: user)

      expect(event.participant?(user)).to be_truthy
    end

    it 'is not participating' do
      expect(event.participant?(user)).to be_falsy
    end
  end
end
