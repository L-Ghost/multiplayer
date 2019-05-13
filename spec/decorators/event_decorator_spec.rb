require 'rails_helper'

RSpec.describe EventDecorator do
  let(:event) { create(:event).decorate }

  describe '#date_info' do
    it 'shows info about event date' do
      dt = Time.zone.now + 4.days
      event.event_date = dt

      expect(event.date_info).to eq("Data: #{dt.strftime('%d/%m/%Y')}")
    end
  end

  describe '#location_info' do
    it 'shows info about event location' do
      location = 'Rua dos Tomates, 334'
      event.event_location = location

      expect(event.location_info).to eq("Local: #{location}")
    end
  end

  describe '#total_participants_info' do
    it 'shows info about total participants' do
      create(:event_participation, event: event)
      create(:event_participation, event: event)
      create(:event_participation, event: event)

      expect(event.total_participants_info).to eq('Total Participantes: 3')
    end
  end

  describe '#max_participants_info' do
    it 'shows info about participants number limit' do
      event.user_limit = 4

      expect(event.max_participants_info).to eq('Máximo Participantes: 4')
    end
  end

  describe '#attendance_info' do
    it 'shows comparison of participants and user limit' do
      event.user_limit = 4
      create(:event_participation, event: event)
      create(:event_participation, event: event)

      expect(event.attendance_info).to eq('Participantes: 2/4')
    end
  end

  describe '#new_request' do
    it 'shows link to creation of new request' do
      regex = %r{href=\"\/events\/#{event.id}\/event_request\"}
      expect(event.new_request).to match(regex)
    end
  end
end
