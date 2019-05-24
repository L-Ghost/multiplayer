class Event < ApplicationRecord
  enum event_type: %i[presential online]

  belongs_to :user
  belongs_to :game_release
  has_many :event_participations, dependent: :destroy
  has_many :event_invites, dependent: :destroy
  has_many :event_requests, dependent: :destroy
  has_many :participants, through: :event_participations, source: :user

  def total_participants
    event_participations.count
  end

  def full?
    total_participants == user_limit
  end
end
