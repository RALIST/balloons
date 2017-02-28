class Subcategory < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :products, through: :items
  before_save :sanitize

  private
  def sanitize
    self.name = name.downcase.strip
  end
end
