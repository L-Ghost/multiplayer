class SendNewSentInviteJob < ApplicationJob
  queue_as :default

  def perform(event_invite_id)
    event_invite = EventInvite.find(event_invite_id)

    EventInviteMailer.sent_invite(event_invite.id).deliver_now
  end
end
