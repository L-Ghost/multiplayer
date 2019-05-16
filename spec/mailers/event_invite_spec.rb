require 'rails_helper'

RSpec.describe EventInviteMailer, type: :mailer do
  describe '.sent_invite' do
    let(:event_invite) { create(:event_invite) }

    it 'renders the headers' do
      e = event_invite.event
      u = event_invite.invitee
      subject = "Você convidou o usuário #{u.nickname} para o evento #{e.title}"

      mail = EventInviteMailer.sent_invite(event_invite.id)

      expect(mail.subject).to eq(subject)
      expect(mail.to).to include(event_invite.user.email)
    end

    it 'renders the body' do
      event = event_invite.event
      dt = event.event_date
      mail = EventInviteMailer.sent_invite(event_invite.id)

      msg = 'Foi enviado um email ao usuário com mais detalhes sobre o evento'
      msg2 = 'Aguarde a resposta do usuário'
      expect(mail.body).to include(event.title)
      expect(mail.body).to include(msg)
      expect(mail.body).to include(msg2)
      expect(mail.body).to include('Detalhes do Evento')
      expect(mail.body).to include("Data: #{dt.strftime('%d/%m/%Y')}")
      expect(mail.body).to include("Local: #{event.event_location}")
    end
  end

  describe '.received_invite' do
    let(:event_invite) { create(:event_invite) }

    it 'renders the headers' do
      subject = "Você foi convidado para o evento #{event_invite.event.title}"

      mail = EventInviteMailer.received_invite(event_invite.id)

      expect(mail.subject).to eq(subject)
      expect(mail.to).to include(event_invite.invitee.email)
    end

    it 'renders the body' do
      e = event_invite.event
      dt = e.event_date
      u = event_invite.user.nickname
      mail = EventInviteMailer.received_invite(event_invite.id)

      msg = "O usuário #{u} te convidou para participar do evento #{e.title}"
      msg2 = 'Acesse nosso site para responder sua solicitação'
      expect(mail.body).to include(e.title)
      expect(mail.body).to include(msg)
      expect(mail.body).to include(msg2)
      expect(mail.body).to include('Detalhes do Evento')
      expect(mail.body).to include("Data: #{dt.strftime('%d/%m/%Y')}")
      expect(mail.body).to include("Local: #{e.event_location}")
    end
  end
end
