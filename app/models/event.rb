class Event < ApplicationRecord
  enum event_type: %i[presential online]

  belongs_to :user
  belongs_to :game_platform
  has_many :event_participations, dependent: :destroy
end
