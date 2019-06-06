class EventInvites::Approve
  def initialize(event_invite)
    @event_invite = event_invite
  end

  def call
    @event_invite.approved!
    EventParticipation.create(
      event: @event_invite.event, user: @event_invite.invitee
    )
  end
end
