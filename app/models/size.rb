class Size < ApplicationRecord
  has_many :items, through: :item_sizes
  validates :in_cm, :in_inch, :belbal, presence: true, uniqueness: true
  before_save :sanitize

  private
  def sanitize
    self.in_cm = in_cm.downcase
    self.in_inch = in_inch.downcase
    self.belbal = belbal.downcase
  end
end
