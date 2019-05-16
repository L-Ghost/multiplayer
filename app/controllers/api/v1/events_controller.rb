class Api::V1::EventsController < Api::V1::ApplicationController
  def index
    @events = Event.all
    render status: :ok, json: @events
  end

  def show
    @event = Event.find_by(id: params[:id])
    return render status: :ok, json: @event if @event

    render status: :not_found, json: 'Não existe um evento com o ID informado'
  end
end
