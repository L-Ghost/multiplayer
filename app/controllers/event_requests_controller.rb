class EventRequestsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    EventRequestService.create_request(@event, current_user)
    flash[:notice] = I18n.t('event.request.sent.successful')
    redirect_to event_path(@event)
  end

  def accept
    approve_request
    flash[:notice] = I18n.t('event.request.accepted')
    redirect_to(@event_request.event)
  end

  def decline
    decline_request
    flash[:notice] = I18n.t('event.request.declined')
    redirect_to(@event_request.event)
  end

  private

  def approve_request
    @event_request = EventRequest.find(params[:id])
    @event_request.approved!
    EventParticipation.create(
      event: @event_request.event, user: @event_request.user
    )
  end

  def decline_request
    @event_request = EventRequest.find(params[:id])
    @event_request.declined!
  end
end
