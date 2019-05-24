class GameRelease < ApplicationRecord
  belongs_to :game
  belongs_to :platform

  def game_and_platform
    "#{game.name} - #{platform.name}"
  end
end
