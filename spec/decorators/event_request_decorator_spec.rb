require 'rails_helper'

RSpec.describe EventRequestDecorator do
  let(:event_request) { create(:event_request).decorate }

  describe '#accept_button' do
    it 'shows request acceptance button' do
      regex = %r{action=\"\/event_requests\/#{event_request.id}\/accept\"}
      expect(event_request.accept_button).to match(regex)
    end
  end

  describe '#decline_button' do
    it 'shows request declination button' do
      regex = %r{action=\"\/event_requests\/#{event_request.id}\/decline\"}
      expect(event_request.decline_button).to match(regex)
    end
  end

  describe '#sent_subject' do
    it 'shows info about request for taking part in event' do
      msg = "Você solicitou participar do Evento: #{event_request.event.title}"
      expect(event_request.sent_subject).to eq(msg)
    end
  end

  describe '#user_request_info' do
    it 'shows info about user which made the request' do
      user = event_request.user.nickname
      msg = "O usuário #{user} deseja participar de seu Evento"
      expect(event_request.user_request_info).to eq(msg)
    end
  end
end
