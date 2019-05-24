class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_date,
             :event_location, :owner, :game, :platform

  def event_date
    I18n.l(object.event_date)
  end

  def owner
    { owner_id: object.user.id, owner_name: object.user.nickname }
  end

  def game
    {
      game_id: object.game_release.game.id,
      game_name: object.game_release.game.name
    }
  end

  def platform
    {
      platform_id: object.game_release.platform.id,
      platform_name: object.game_release.platform.name
    }
  end
end
