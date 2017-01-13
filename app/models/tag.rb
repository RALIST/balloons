class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('DISTINCT name')}
end
