class EventDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :event_request

  LENGTH = 50

  def brief_description
    description.truncate(LENGTH)
  end

  def owner_info
    I18n.t('event.created_by', user: user.nickname)
  end

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

  def link
    link_to(I18n.t('event.view'), object)
  end

  def participations_block(user)
    object.owner?(user) ? event_owner_block : common_user_block(user)
  end

  def new_request
    link_to(
      I18n.t('event.new_request'),
      event_requests_path(event_id: id),
      method: :post
    )
  end

  private

  def event_owner_block
    render_participation_requests + render_participation_invite_form
  end

  def render_participation_requests
    render partial: 'events/participation_requests', locals: {
      requests: event_requests.sent.decorate
    }
  end

  def render_participation_invite_form
    render partial: 'events/participation_invite_form', locals: {
      event: object
    }
  end

  def common_user_block(user)
    return render_requested_by if object.requested_by?(user)

    return render_invite_for(user) if object.invite_for?(user)

    render_participation_request_form(user)
  end

  def render_requested_by
    render inline: "<h4>#{t('event.sent_request')}</h4>"
  end

  def render_invite_for(user)
    render partial: 'events/participation_invite', locals: {
      invite: event_invites.where(invitee: user).last.decorate
    }
  end

  def render_participation_request_form(user)
    render partial: 'events/participation_request_form', locals: {
      event: self, user: user
    }
  end
end
