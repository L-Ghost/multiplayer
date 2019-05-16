require 'rails_helper'

RSpec.describe SendNewSentInviteJob, type: :job do
  let(:event_invite) { create(:event_invite) }
  let(:message_chain) { %i[sent_invite deliver_now] }

  describe '#perform' do
    it 'calls on the EventInviteMailer' do
      allow(EventInvite).to receive(:find).and_return(event_invite)
      allow(EventInviteMailer).to receive_message_chain(message_chain)

      described_class.new.perform(event_invite.id)

      expect(EventInviteMailer).to have_received(:sent_invite)
    end
  end

  describe '.perform_later' do
    it 'adds the job to the queue' do
      allow(EventInviteMailer).to receive_message_chain(message_chain)

      described_class.perform_later(event_invite.id)

      expect(enqueued_jobs.last[:job]).to eq(described_class)
    end
  end
end
