class Subposition < ApplicationRecord
  belongs_to :position
  belongs_to :item
end
