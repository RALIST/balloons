class Category < ApplicationRecord
  has_many :items
  validates :title, presence: true, uniqueness: true
  before_save :sanitize

  private

  def sanitize
    self.title = title.downcase
  end
end
