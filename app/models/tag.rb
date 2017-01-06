class Tag < ApplicationRecord
  belongs_to :taggable
  validates :name, presence:  true
end
