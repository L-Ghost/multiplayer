class Category < ApplicationRecord
  has_many :category_games, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
