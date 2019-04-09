class Platform < ApplicationRecord
  belongs_to :company

  has_one_attached :logo

  validates :name, presence: true, uniqueness: true
  validate :logo_validation

  private

  def logo_validation
    !logo.attached? && errors[:logo] << 'precisa ser enviado'
  end
end
