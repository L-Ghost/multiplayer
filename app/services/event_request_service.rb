module EventRequestService
  class << self
    def create_request(event, user)
      event_request = EventRequest.create(event: event, user: user)
      event_request.sent!
      send_emails(event_request)
    end

    def approve_request(event_request)
      event_request.approved!
      EventParticipation.create(
        event: event_request.event, user: event_request.user
      )
    end

    private

    def send_emails(event_request)
      event_request.sent_request
      event_request.received_request
    end
  end
end
