class Subposition < ApplicationRecord
  belongs_to :position
  belongs_to :product, touch: true
  has_one :cart, through: :position
  has_one :item, through: :product
end
