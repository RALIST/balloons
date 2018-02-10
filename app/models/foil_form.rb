class FoilForm < ApplicationRecord
  has_many :items
  before_save :sanitize
  validates :name, uniqueness: true

  private

  def sanitize
    self.name = name.strip.downcase
  end
end
