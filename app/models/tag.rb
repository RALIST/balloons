class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :compositions
  validates :name, presence:  true
  has_one :image, as: :imageable

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('distinct on (name) * ') }

  after_commit :set_image

  def set_image
    if !self.image
      Image.create do |image|
        image.img = compositions.first.img
        self.image = image
      end
    end
  end

end
