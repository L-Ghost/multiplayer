require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should have_many(:game_users) }
  it { should have_many(:events) }
  it { should have_many(:event_participations) }
  it { should have_many(:sent_invites) }
  it { should have_many(:received_invites) }
  it { should have_many(:sent_requests) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  describe '#future_events' do
    it 'should list future events' do
      event1 = create(:event, user: user, event_date: Time.zone.now + 3.days)
      event2 = create(:event, user: user, event_date: Time.zone.now + 4.days)

      future_events = user.future_events

      expect(future_events.count).to eq(2)
      expect(future_events).to include(event1)
      expect(future_events).to include(event2)
    end

    it 'should not list past events' do
      event1 = create(:event, user: user, event_date: Time.zone.now - 2.days)
      event2 = create(:event, user: user, event_date: Time.zone.now - 3.days)

      future_events = user.future_events

      expect(future_events.count).to eq(0)
      expect(future_events).not_to include(event1)
      expect(future_events).not_to include(event2)
    end
  end

  describe '#event_options' do
    it 'should list events that are yet to occur' do
      event1 = create(:event, user: user, event_date: Time.zone.now + 3.days)
      event2 = create(:event, user: user, event_date: Time.zone.now + 4.days)
      event3 = create(:event, user: user, event_date: Time.zone.now - 2.days)

      event_options = user.event_options
      text_options = event_options.to_s

      expect(event_options.count).to eq(2)
      expect(text_options).to include(event1.title)
      expect(text_options).to include(event2.title)
      expect(text_options).not_to include(event3.title)
    end

    it 'should not list event options if user has no events' do
      create(:event) # not from tested user

      expect(user.event_options.count).to eq(0)
    end
  end
end
