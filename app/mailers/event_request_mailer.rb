class EventRequestMailer < ApplicationMailer
  def sent_request(event_request_id)
    @event_request = EventRequest.find(event_request_id).decorate

    mail(
      to: @event_request.user.email,
      subject: @event_request.sent_subject
    )
  end

  def received_request(event_request_id)
    @event_request = EventRequest.find(event_request_id).decorate

    mail(
      to: @event_request.event.user.email,
      subject: I18n.t('event.new_request_sent')
    )
  end
end
