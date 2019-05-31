require 'rails_helper'

RSpec.describe EventDecorator do
  let(:event) { build(:event).decorate }

  context 'infos' do
    describe '#brief_description' do
      it 'limits description text to specified character length' do
        desc = 'Jogar videogame por bastante tempo até chegar de manhã'
        brief_desc = 'Jogar videogame por bastante tempo até chegar d...'
        event.description = desc

        expect(event.brief_description.length).to eq(EventDecorator::LENGTH)
        expect(event.brief_description).to eq(brief_desc)
      end

      it 'shows full description for small texts' do
        desc = 'Jogar bastante videogame'
        event.description = desc

        expect(event.brief_description.length).to eq(24)
        expect(event.brief_description).to eq(desc)
      end
    end

    describe '#owner_info' do
      it 'shows username of event creator' do
        expect(event.owner_info).to eq("Criado por: #{event.user.nickname}")
      end
    end

    describe '#date_info' do
      it 'shows info about event date' do
        time = Time.zone.now + 4.days
        event.event_date = time

        expect(event.date_info).to eq("Data: #{time.strftime('%d/%m/%Y')}")
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
        create_list(:event_participation, 2, event: event)

        expect(event.attendance_info).to eq('Participantes: 2/4')
      end
    end
  end

  context 'links' do
    let(:event) { create(:event).decorate }

    describe '#link' do
      it 'shows link for viewing details of event' do
        regex = %r{href=\"\/events\/#{event.id}\"}
        expect(event.link).to match(regex)
      end

      it 'shows correct event id' do
        id = event.id + 1
        regex = %r{href=\"\/events\/#{id}\"}
        expect(event.link).not_to match(regex)
      end
    end

    describe '#new_request' do
      it 'shows link to creation of new request' do
        regex = %r{href=\"\/event_requests\?event_id\=#{event.id}\"}
        expect(event.new_request).to match(regex)
      end

      it 'shows event id equals to current event' do
        id = event.id + 1
        regex = %r{href=\"\/event_requests\?event_id\=#{id}\"}
        expect(event.new_request).not_to match(regex)
      end
    end
  end
end
