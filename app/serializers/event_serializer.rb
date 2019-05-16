class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_date,
             :event_location, :owner, :game, :platform

  def owner
    { owner_id: object.user.id, owner_name: object.user.nickname }
  end

  def game
    {
      game_id: object.game_platform.game.id,
      game_name: object.game_platform.game.name
    }
  end

  def platform
    {
      platform_id: object.game_platform.platform.id,
      platform_name: object.game_platform.platform.name
    }
  end
end
