class ItemsInComposition < ApplicationRecord
  belongs_to :item
  belongs_to :composition
end
