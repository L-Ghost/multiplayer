class HomeController < ApplicationController
  def index
    @games = GameDecorator.decorate_collection(Game.last(5))
    @events = EventDecorator.decorate_collection(
      Event.where('event_date >= ?', Time.zone.today).last(5)
    )
  end
end
