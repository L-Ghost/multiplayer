class EventDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :event_request

  def date_info
    "#{I18n.t(:date_text)}: #{I18n.l(event_date)}"
  end

  def location_info
    "#{I18n.t(:location_text)}: #{event_location}"
  end

  def total_participants_info
    "#{I18n.t('total.participants')}: #{total_participants}"
  end

  def max_participants_info
    "#{I18n.t('max.participants')}: #{user_limit}"
  end

  def attendance_info
    "#{I18n.t('participant.other')}: #{total_participants}/#{user_limit}"
  end

  def new_request
    link_to(
      I18n.t('event.new_request'),
      event_request_event_path(object),
      method: :post
    )
  end
end
