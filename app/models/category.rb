class Category < ApplicationRecord
  has_many :game_categorizations, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
