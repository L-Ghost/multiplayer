class EventInviteDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :event

  def accept_button
    button_to I18n.t(:accept), accept_event_invite_path(object), method: :put
  end

  def decline_button
    button_to I18n.t(:decline), decline_event_invite_path(object), method: :put
  end

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
