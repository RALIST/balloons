class Subposition < ApplicationRecord
  belongs_to :position, touch:  true
  belongs_to :product, touch:  true
  has_one :item, through: :product
end
