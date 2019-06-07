class HomeController < ApplicationController
  DEFAULT_LATEST = 5

  def index
    @games = GameDecorator.decorate_collection(
      GamesQuery.new.latest(HomeController::DEFAULT_LATEST)
    )
    @events = EventDecorator.decorate_collection(
      EventsQuery.new.latest(HomeController::DEFAULT_LATEST)
    )
  end
end
