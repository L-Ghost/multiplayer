class Event < ApplicationRecord
  enum event_type: %i[presential online]

  belongs_to :user
  belongs_to :game_platform
  has_many :event_participations, dependent: :destroy

  def total_participants
    event_participations.count
  end

  def total_participants_info
    "#{I18n.t('total.participants')}: #{total_participants}"
  end

  def max_participants_info
    "#{I18n.t('max.participants')}: #{user_limit}"
  end
end
