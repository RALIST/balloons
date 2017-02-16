class Size < ApplicationRecord
  has_many :items, through: :products
  has_many :products
  validates :in_cm, :in_inch, :belbal, presence: true, uniqueness: true
end
