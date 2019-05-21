class EventInvitesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @invited_user = User.find_by('nickname = :q OR email = :q', q: params[:q])

    @message = I18n.t('not.found.user_email')
    invite_user_procedure unless @invited_user.nil?

    flash[:notice] = @message
    redirect_to @event
  end

  private

  def invite_user_procedure
    if invite_exists?
      @message = I18n.t('event.invite.already_sent')
    else
      create_event_invite
      send_emails
      @message = invited_user_message
    end
  end

  def invite_exists?
    @event_invite = EventInvite.find_by(
      event: @event, user: current_user, invitee: @invited_user
    )
    !@event_invite.nil?
  end

  def create_event_invite
    @event_invite = EventInvite.create(
      event: @event,
      user: current_user,
      invitee: @invited_user
    )
  end

  def send_emails
    @event_invite.sent_invite
    @event_invite.received_invite
  end

  def invited_user_message
    I18n.t('event.invite.sent.nickname', nickname: @invited_user.nickname)
  end
end
