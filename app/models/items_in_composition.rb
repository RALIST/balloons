class ItemsInComposition < ApplicationRecord
  belongs_to :item
  belongs_to :composition
  belongs_to :product
end
