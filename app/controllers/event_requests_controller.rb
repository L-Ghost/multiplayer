class EventRequestsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    create_event_request
    send_emails
    flash[:notice] = I18n.t('event.request.sent.successful')
    redirect_to event_path(@event)
  end

  def accept
    approve_request
    @user = current_user
    EventParticipation.create(event: @event_request.event, user: @user)
    flash[:notice] = I18n.t('event.request.accepted')
    redirect_to(@event_request.event)
  end

  def decline
    decline_request
    flash[:notice] = I18n.t('event.request.declined')
    redirect_to(@event_request.event)
  end

  private

  def create_event_request
    @event_request = EventRequest.create(
      event: @event, user: current_user, event_owner: @event.user
    )
    @event_request.sent!
  end

  def send_emails
    @event_request.sent_request
    @event_request.received_request
  end

  def approve_request
    @event_request = EventRequest.find(params[:id])
    @event_request.approved!
  end

  def decline_request
    @event_request = EventRequest.find(params[:id])
    @event_request.declined!
  end
end
