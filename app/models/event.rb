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

  def owner?(user)
    self.user == user
  end

  def requested_by?(user)
    event_requests.where(user: user).any?
  end

  def invite_for?(user)
    event_invites.where(invitee: user, invite_respond: :sent).any?
  end

  def participant?(user)
    event_participations.where(user: user).any?
  end
end
