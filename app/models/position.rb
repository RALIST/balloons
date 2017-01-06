class Position < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :composition
end
