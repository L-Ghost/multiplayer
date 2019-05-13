require 'rails_helper'

RSpec.describe EventRequestDecorator do
  let(:event_request) { create(:event_request).decorate }

  describe '#accept_link' do
    it 'shows request acceptance link' do
      regex = %r{href=\"\/event_requests\/#{event_request.id}\/accept\"}
      expect(event_request.accept_link).to match(regex)
    end
  end

  describe '#decline_link' do
    it 'shows request declination link' do
      regex = %r{href=\"\/event_requests\/#{event_request.id}\/decline\"}
      expect(event_request.decline_link).to match(regex)
    end
  end
end
