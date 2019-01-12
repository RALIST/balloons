class Receiver < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_and_belongs_to_many :compositions
  validates :title, presence: true
  has_one :image, as: :imageable



  after_commit :set_image

  def set_image
    if !self.image
      Image.create do |image|
        image.img = compositions.first.img
        self.image = image
      end
    end
  end

  def resolve_friendly_id_conflict(candidates)
    candidates.first
  end

  def set_slug(normalized_slug = nil)
    if should_generate_new_friendly_id?
      candidates = FriendlyId::Candidates.new(self, normalized_slug || send(friendly_id_config.base))
      slug = slug_generator.generate(candidates) || resolve_friendly_id_conflict(candidates)
      send "#{friendly_id_config.slug_column}=", slug
    end
  end
end
