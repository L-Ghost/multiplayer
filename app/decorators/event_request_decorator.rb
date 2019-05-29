class EventRequestDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :event

  def accept_button
    button_to I18n.t(:accept), accept_event_request_path(object), method: :put
  end

  def decline_button
    button_to I18n.t(:decline), decline_event_request_path(object), method: :put
  end

  def sent_subject
    "#{I18n.t('event.request.sent.subject')}: #{event.title}"
  end

  def user_request_info
    I18n.t('event.user_request_info', user: user.nickname)
  end
end
