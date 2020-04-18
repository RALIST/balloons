class Type < ApplicationRecord
  has_many :items
  validates :name, presence: true, uniqueness: true
  before_save :sanitize

  private

  def sanitize
    self.name = name.downcase
  end
end
