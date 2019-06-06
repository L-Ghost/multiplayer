class EventRequests::Approve
  def initialize(event_request)
    @event_request = event_request
  end

  def call
    @event_request.approved!
    EventParticipation.create(
      event: @event_request.event, user: @event_request.user
    )
  end
end
