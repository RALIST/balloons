class Subposition < ApplicationRecord
  belongs_to :position, touch:  true
  belongs_to :product, touch:  true
  has_one :cart, through: :position
  has_one :item, through: :product
end
