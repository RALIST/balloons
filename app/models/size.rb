class Size < ApplicationRecord
  has_many :items, through: :products
  has_many :products
  validates :in_inch, presence: true, uniqueness: true

  after_find :to_cm

  def to_cm
    self.in_cm = in_inch * 2.54 unless self.in_cm.present?
  end

end
