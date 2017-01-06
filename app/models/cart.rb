class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions

  def total_price
  	self.compositions.map{|c| c.price.to_f}.sum
  end
end
