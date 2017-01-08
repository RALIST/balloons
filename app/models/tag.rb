class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, presence:  true
end
