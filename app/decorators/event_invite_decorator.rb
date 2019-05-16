class EventInviteDecorator < ApplicationDecorator
  delegate_all
  decorates_association :event

  def sent_subject
    I18n.t(
      'event.invite.sent.subject',
      user: invitee.nickname,
      event: event.title
    )
  end

  def received_subject
    I18n.t('event.invite.received.subject', event: event.title)
  end

  def received_invite_info
    I18n.t(
      'event.invite.received.mailer_message',
      user: user.nickname,
      event: event.title
    )
  end
end
