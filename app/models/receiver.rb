class Receiver < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :personable, polymorphic: true
  validates :title, presence: true

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
