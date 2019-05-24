class Game < ApplicationRecord
  has_one_attached :photo

  has_many :game_categorizations, dependent: :destroy
  has_many :game_releases, dependent: :destroy
  has_many :game_users, dependent: :destroy

  validates :name, :release_year, presence: true
  validates :release_year, numericality: true
end
