require 'rails_helper'

RSpec.describe EventRequest, type: :model do
  it { should belong_to(:event) }
  it { should belong_to(:user) }

  it { should define_enum_for(:request_status) }

  let(:event_request) { create(:event_request) }

  describe '#sent_request' do
    it 'enqueues sent request email' do
      allow(SendNewSentRequestJob).to receive(:perform_later)

      event_request.sent_request

      expect(SendNewSentRequestJob).to have_received(:perform_later)
    end
  end

  describe '#received_request' do
    it 'enqueues received request email' do
      allow(SendNewReceivedRequestJob).to receive(:perform_later)

      event_request.received_request

      expect(SendNewReceivedRequestJob).to have_received(:perform_later)
    end
  end
end
