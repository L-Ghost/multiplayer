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
end
