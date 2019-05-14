require 'rails_helper'

RSpec.describe SendNewSentRequestJob, type: :job do
  describe '#perform' do
    it 'calls on the EventRequestMailer' do
      event_request = create(:event_request)
      allow(EventRequest).to receive(:find).and_return(event_request)
      allow(EventRequestMailer).to receive_message_chain(:sent_request, :deliver_now)

      described_class.new.perform(event_request.id)

      expect(EventRequestMailer).to have_received(:sent_request)
    end
  end

  describe '.perform_later' do
    it 'adds the job to the queue' do
      event_request = create(:event_request)
      allow(EventRequestMailer).to receive_message_chain(:sent_request, :deliver_now)

      described_class.perform_later(event_request.id)

      expect(enqueued_jobs.last[:job]).to eq(described_class)
    end
  end
end
