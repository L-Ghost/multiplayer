class EventRequestsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    EventRequests::Create.new(event: @event, user: current_user).call
    flash[:notice] = I18n.t('event.request.sent.successful')
    redirect_to event_path(@event)
  end

  def accept
    @event_request = EventRequest.find(params[:id])
    EventRequests::Approve.new(@event_request).call
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
