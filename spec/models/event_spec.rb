require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  describe '#total_participants' do
    it 'should count correct number of participants' do
      create(:event_participation, event: event)
      create(:event_participation, event: event)

      expect(event.total_participants).to eq(2)
    end
  end

  describe '#total_participants_info' do
    it 'should show correct number of participants' do
      create(:event_participation, event: event)
      create(:event_participation, event: event)
      create(:event_participation, event: event)

      expect(event.total_participants_info).to eq('Total Participantes: 3')
    end
  end

  describe '#max_participants_info' do
    it 'should show correct number of user limit' do
      event.user_limit = 4

      expect(event.max_participants_info).to eq('Máximo Participantes: 4')
    end
  end
end
