class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  belongs_to :taggable, polymorphic: true
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').select("distinct on (name) *")}


  # def to_param
  #   name = Russian::transliterate(self.name)
  #   [id, name.downcase.split(' ')].join('-')
  # end
end
