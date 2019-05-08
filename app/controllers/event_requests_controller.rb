class EventRequestsController < ApplicationController
  def accept
    approved_request
    @user = current_user
    EventParticipation.create(event: @event_request.event, user: @user)
    flash[:notice] = 'Pedido aceito com sucesso!'
    redirect_to(@event_request.event)
  end

  def decline
    declined_request
    flash[:notice] = 'Pedido recusado!'
    redirect_to(@event_request.event)
  end

  private

  def approved_request
    @event_request = EventRequest.find(params[:id])
    @event_request.approved!
  end

  def declined_request
    @event_request = EventRequest.find(params[:id])
    @event_request.declined!
  end
end
