class Category < ApplicationRecord
  has_many :items
  validates :title, presence: true, uniqueness: true
  before_save :sanitize_title

  def sanitize_title
    self.title = title.downcase
  end
end
