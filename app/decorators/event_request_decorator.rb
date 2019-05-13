class EventRequestDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all

  def accept_link
    link_to I18n.t(:accept), accept_event_request_path(object), method: :put
  end

  def decline_link
    link_to I18n.t(:decline), decline_event_request_path(object), method: :put
  end
end
