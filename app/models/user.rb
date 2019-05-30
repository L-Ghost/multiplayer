class User < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :state, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :game_users, dependent: :destroy
  has_many :games, through: :game_users, dependent: :destroy
  has_many :game_releases, through: :games
  has_many :events, dependent: :destroy
  has_many :event_participations, dependent: :destroy
  has_many :sent_invites,
           class_name: 'EventInvite',
           foreign_key: :user_id,
           dependent: :destroy,
           inverse_of: :user
  has_many :received_invites, -> { where(invite_status: :sent) },
           class_name: 'EventInvite',
           foreign_key: :invitee_id,
           dependent: :destroy,
           inverse_of: :invitee
  has_many :sent_requests,
           class_name: 'EventRequest',
           foreign_key: :user_id,
           dependent: :destroy,
           inverse_of: :user

  has_one_attached :avatar

  validates :name, presence: true
  validates :nickname, presence: true, on: :update
  validates :nickname, uniqueness: true, on: :update

  def future_events
    events.where(['event_date >= ?', Time.zone.now])
  end

  def event_options
    future_events.map { |e| [e.title, e.id] }
  end
end
