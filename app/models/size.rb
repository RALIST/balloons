class Size < ApplicationRecord
  has_many :items, through: :products
  has_many :products
  validates :in_inch, presence: true, uniqueness: true
end
