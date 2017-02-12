class Color < ApplicationRecord
  has_many :tones
  before_save :sanitize
  validates :name, presence: true, uniqueness: true
  private
  def sanitize
    self.name = name.downcase
  end
end
