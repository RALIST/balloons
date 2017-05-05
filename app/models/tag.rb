class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :taggable, polymorphic: true
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').select("distinct on (name) * ")}

  def resolve_friendly_id_conflict(candidates)
    candidates.first
  end

# Sets the slug.
  def set_slug(normalized_slug = nil)
    if should_generate_new_friendly_id?
      candidates = FriendlyId::Candidates.new(self, normalized_slug || send(friendly_id_config.base))
      slug = slug_generator.generate(candidates) || resolve_friendly_id_conflict(candidates)
      send "#{friendly_id_config.slug_column}=", slug
    end
  end
  # def to_param
  #   name = Russian::transliterate(self.name)
  #   [id, name.downcase.split(' ')].join('-')
  # end
end
