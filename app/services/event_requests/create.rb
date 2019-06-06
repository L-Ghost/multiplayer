class EventRequests::Create
  def initialize(event:, user:)
    @event = event
    @user = user
  end

  def call
    @event_request = EventRequest.create(event: @event, user: @user)
    @event_request.sent!
    send_emails
  end

  private

  def send_emails
    @event_request.sent_request
    @event_request.received_request
  end
end
