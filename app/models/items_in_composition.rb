class ItemsInComposition < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :composition
  belongs_to :product
end
