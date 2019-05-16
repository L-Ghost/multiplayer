class EventInviteMailer < ApplicationMailer
  def sent_invite(event_invite_id)
    @event_invite = EventInvite.find(event_invite_id).decorate

    mail(
      to: @event_invite.user.email,
      subject: @event_invite.sent_subject
    )
  end

  def received_invite(event_invite_id)
    @event_invite = EventInvite.find(event_invite_id).decorate

    mail(
      to: @event_invite.invitee.email,
      subject: @event_invite.received_subject
    )
  end
end
