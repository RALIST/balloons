class Product < ApplicationRecord
  belongs_to :item
  belongs_to :size
  validates :item_id, presence: true
end
