class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :compositions
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('distinct on (name) * ') }

  def image(size)
    compositions.order('RANDOM()').map{|c| c.img(size)}.first
  end
end
