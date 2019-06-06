class EventInvites::Create
  def initialize(event:, user:, invited_user:)
    @event = event
    @user = user
    @invited_user = invited_user
  end

  def call
    return false if invite_exists?

    create_event_invite
    send_emails
    true
  end

  private

  def invite_exists?
    !EventInvite.find_by(
      event: @event, user: @user, invitee: @invited_user
    ).nil?
  end

  def create_event_invite
    @event_invite = EventInvite.create(
      event: @event,
      user: @user,
      invitee: @invited_user
    )
    @event_invite.sent!
    @event_invite
  end

  def send_emails
    @event_invite.sent_invite
    @event_invite.received_invite
  end
end
