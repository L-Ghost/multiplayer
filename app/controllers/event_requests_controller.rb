class EventRequestsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    EventRequestService.create_request(@event, current_user)
    flash[:notice] = I18n.t('event.request.sent.successful')
    redirect_to event_path(@event)
  end

  def accept
    @event_request = EventRequest.find(params[:id])
    EventRequestService.approve_request(@event_request)
    flash[:notice] = I18n.t('event.request.accepted')
    redirect_to(@event_request.event)
  end

  def decline
    @event_request = EventRequest.find(params[:id])
    @event_request.declined!
    flash[:notice] = I18n.t('event.request.declined')
    redirect_to(@event_request.event)
  end
end
