class EventRequestsController < ApplicationController
  before_action :fetch_current_request, only: %i[accept decline]

  def create
    @event = Event.find(params[:event_id])
    EventRequests::Create.new(event: @event, user: current_user).call
    flash[:notice] = I18n.t('event.request.sent.successful')
    redirect_to event_path(@event)
  end

  def accept
    EventRequests::Approve.new(@event_request).call
    flash[:notice] = I18n.t('event.request.accepted')
    redirect_to(@event_request.event)
  end

  def decline
    @event_request.declined!
    flash[:notice] = I18n.t('event.request.declined')
    redirect_to(@event_request.event)
  end

  private

  def fetch_current_request
    @event_request = EventRequest.find(params[:id])
  end
end
