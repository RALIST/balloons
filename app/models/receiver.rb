class Receiver < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :personable, polymorphic: true
  validates :title, presence: true
  has_one :image, as: :imageable
  after_find :set_image


  def set_image
    if self.image.blank?
      img_url = 'https:' + self.compositions.order('RANDOM()').first.img(:original)
      self.image = Image.create(img_remote_url: img_url)
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
