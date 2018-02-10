class Texture < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true, presence: true
  before_save :sanitize

  private

  def sanitize
    self.name = name.downcase
  end
end
