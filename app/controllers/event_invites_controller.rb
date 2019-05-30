class EventInvitesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @invited_user = User.find_by('nickname = :q OR email = :q', q: params[:q])

    @message = I18n.t('not.found.user_email')
    invite_user_procedure unless @invited_user.nil?

    flash[:notice] = @message
    redirect_to @event
  end

  def received_invites
    @received_invites = EventInviteDecorator.decorate_collection(
      EventInvite.where(invitee: current_user).sent
    )
  end

  def accept
    @event_invite = EventInvite.find(params[:id])
    approve_invite
    flash[:notice] = I18n.t('event.invite.accepted')
    redirect_to refered_by_event? ? current_event : my_invites
  end

  def decline
    @event_invite = EventInvite.find(params[:id])
    @event_invite.declined!
    flash[:notice] = I18n.t('event.invite.declined')
    redirect_to refered_by_event? ? current_event : my_invites
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
    @event_invite.sent!
  end

  def send_emails
    @event_invite.sent_invite
    @event_invite.received_invite
  end

  def invited_user_message
    I18n.t('event.invite.sent.nickname', nickname: @invited_user.nickname)
  end

  def approve_invite
    @event_invite.approved!
    EventParticipation.create(event: @event_invite.event, user: current_user)
  end

  def refered_by_event?
    referer_path = URI(request.referer).path
    referer_path == event_path(@event_invite.event)
  end

  def current_event
    event_path(@event_invite.event)
  end

  def my_invites
    received_invites_event_invites_path
  end
end
