require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#total_participants' do
    it 'counts number of participants' do
      event = create(:event)
      create(:event_participation, event: event)
      create(:event_participation, event: event)

      expect(event.total_participants).to eq(2)
    end
  end

  describe '#full?' do
    it 'is full' do
      event = create(:event, user_limit: 5)
      5.times { create(:event_participation, event: event) }

      expect(event.full?).to be_truthy
    end

    it 'is not full' do
      event = create(:event, user_limit: 5)
      3.times { create(:event_participation, event: event) }

      expect(event.full?).to be_falsy
    end
  end
end
