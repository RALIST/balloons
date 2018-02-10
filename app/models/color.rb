class Color < ApplicationRecord
  has_many :tones
  has_many :items
  has_many :products, through: :items
  before_save :sanitize
  validates :name, presence: true, uniqueness: true

  private

  def sanitize
    self.name = name.downcase
  end
end
