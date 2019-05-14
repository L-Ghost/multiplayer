require 'rails_helper'

RSpec.describe EventRequestMailer, type: :mailer do
  describe '.sent_request' do
    let(:event_request) { create(:event_request) }

    it 'renders the headers' do
      event = event_request.event
      subject = "Você solicitou participar do Evento: #{event.title}"

      mail = EventRequestMailer.sent_request(event_request.id)

      expect(mail.subject).to eq(subject)
      expect(mail.to).to include(event_request.user.email)
    end

    it 'renders the body' do
      event = event_request.event
      dt = event.event_date
      mail = EventRequestMailer.sent_request(event_request.id)

      msg = 'Sua solicitação foi enviada ao administrador do Evento'
      msg2 = 'Aguarde resposta do administrador do Evento'
      expect(mail.body).to include(event.title)
      expect(mail.body).to include(msg)
      expect(mail.body).to include(msg2)
      expect(mail.body).to include('Detalhes do Evento')
      expect(mail.body).to include("Data: #{dt.strftime('%d/%m/%Y')}")
      expect(mail.body).to include("Local: #{event.event_location}")
    end
  end

  describe '.received_request' do
    let(:event_request) { create(:event_request) }

    it 'renders the headers' do
      subject = 'Seu evento tem uma nova solicitação'

      mail = EventRequestMailer.received_request(event_request.id)

      expect(mail.subject).to eq(subject)
      expect(mail.to).to include(event_request.event.user.email)
    end

    it 'renders the body' do
      event = event_request.event
      dt = event.event_date
      user = event_request.user.nickname
      mail = EventRequestMailer.received_request(event_request.id)

      msg = "O usuário #{user} deseja participar de seu Evento"
      msg2 = 'Acesse nosso site para responder sua solicitação'
      expect(mail.body).to include(event.title)
      expect(mail.body).to include(msg)
      expect(mail.body).to include(msg2)
      expect(mail.body).to include('Detalhes do Evento')
      expect(mail.body).to include("Data: #{dt.strftime('%d/%m/%Y')}")
      expect(mail.body).to include("Local: #{event.event_location}")
    end
  end
end
