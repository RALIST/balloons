class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :compositions
  validates :name, presence:  true
  has_one :image, as: :imageable

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('distinct on (name) * ') }
  after_find :set_image

  def set_image
    if self.image.blank?
      img_url = 'https:' + self.compositions.order('RANDOM()').first.img(:original)
      image = Image.create(img_remote_url: img_url)
      self.image << image
    end
  end
end
