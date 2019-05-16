require 'rails_helper'

RSpec.describe EventInviteDecorator do
  let(:event_invite) { create(:event_invite).decorate }

  describe '#sent_subject' do
    it 'shows info about sent invite' do
      u = event_invite.invitee
      e = event_invite.event
      msg = "Você convidou o usuário #{u.nickname} para o evento #{e.title}"

      expect(event_invite.sent_subject).to eq(msg)
    end
  end

  describe '#received_subject' do
    it 'shows info about received invite' do
      msg = "Você foi convidado para o evento #{event_invite.event.title}"
      expect(event_invite.received_subject).to eq(msg)
    end
  end

  describe '#received_invite_info' do
    it 'shows info about user which sent the invite' do
      nick = event_invite.user.nickname
      et = event_invite.event.title
      msg = "O usuário #{nick} te convidou para participar do evento #{et}"

      expect(event_invite.received_invite_info).to eq(msg)
    end
  end
end
