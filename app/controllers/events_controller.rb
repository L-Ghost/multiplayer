class EventsController < ApplicationController
  def new
    @event = Event.new
    @game_releases = current_user.game_releases
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.save
    EventParticipation.create(event: @event, user: current_user)
    flash[:notice] = 'Seu evento foi criado'
    redirect_to @event
  end

  def show
    @event = Event.find(params[:id]).decorate
  end

  def search
    search_param = params[:search]
    return if search_param.blank?

    @events = EventsQuery.new.find_events(search_param)
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :description, :game_release_id,
      :event_date, :user_limit, :event_type, :event_location
    )
  end
end
