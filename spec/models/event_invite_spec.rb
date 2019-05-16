require 'rails_helper'

RSpec.describe EventInvite, type: :model do
  let(:event_invite) { create(:event_invite) }

  describe '#sent_invite' do
    it 'enqueues sent invite email' do
      allow(SendNewSentInviteJob).to receive(:perform_later)

      event_invite.sent_invite

      expect(SendNewSentInviteJob).to have_received(:perform_later)
    end
  end

  describe '#received_invite' do
    it 'enqueues received invite email' do
      allow(SendNewReceivedInviteJob).to receive(:perform_later)

      event_invite.received_invite

      expect(SendNewReceivedInviteJob).to have_received(:perform_later)
    end
  end
end