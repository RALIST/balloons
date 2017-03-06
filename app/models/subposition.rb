class Subposition < ApplicationRecord
  belongs_to :position
  belongs_to :product
  has_one :item, through: :product
end
