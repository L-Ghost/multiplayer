class Company < ApplicationRecord
  has_many :platforms, dependent: :restrict_with_exception

  has_one_attached :logo

  validates :name, presence: true, uniqueness: true
  validate :logo_validation

  private

  def logo_validation
    !logo.attached? && errors[:logo] << 'Logo precisa ser enviado'
  end
end
