class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :compositions
  validates :name, presence:  true
  has_one :image, as: :imageable

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('distinct on (name) * ') }
  after_create :set_image

  def set_image
    self.image.img_remote_url = self.compositions.availible.first.img(:original) unless self.image
  end
end
