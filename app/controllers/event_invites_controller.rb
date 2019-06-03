class EventInvitesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])

    begin
      @invited_user = EventInviteService.find_user(params)
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = I18n.t('not.found.user_email')
      return redirect_to @event
    end

    flash[:notice] = invite_service
    redirect_to params[:user_id].nil? ? @event : @invited_user
  end

  def received_invites
    @received_invites = EventInviteDecorator.decorate_collection(
      EventInvite.where(invitee: current_user).sent
    )
  end

  def accept
    @event_invite = EventInvite.find(params[:id])
    EventInviteService.approve_invite(@event_invite)
    flash[:notice] = I18n.t('event.invite.accepted')
    redirect_after_response
  end

  def decline
    @event_invite = EventInvite.find(params[:id])
    @event_invite.declined!
    flash[:notice] = I18n.t('event.invite.declined')
    redirect_after_response
  end

  private

  def invite_service
    if EventInviteService.invite_user_procedure(
      @event, current_user, @invited_user
    )
      return invited_user_message
    end

    I18n.t('event.invite.already_sent')
  end

  def invited_user_message
    I18n.t('event.invite.sent.nickname', nickname: @invited_user.nickname)
  end

  def redirect_after_response
    redirect_to refered_by_event? ? current_event : my_invites
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
