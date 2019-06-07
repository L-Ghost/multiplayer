class GamesQuery
  def latest(n)
    Game.last(n)
  end
  
  def find_games(params)
    Game.where('lower(name) like lower(?)', "%#{params[:q]}%")
  end
end