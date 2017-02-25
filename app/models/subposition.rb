class Subposition < ApplicationRecord
  belongs_to :position
  belongs_to :product
end
