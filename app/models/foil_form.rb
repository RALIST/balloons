class FoilForm < ApplicationRecord
  has_many :items
  has_many :products, through: :items

  validates :name, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save :sanitize

  private

  def sanitize
    self.name = name.strip.downcase
  end
end
