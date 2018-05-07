class Color < ApplicationRecord
  has_many :tones
  has_many :items
  has_many :products, through: :items
  before_save :sanitize
  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  def set_slug(normalized_slug = nil)
    if should_generate_new_friendly_id?
      candidates = FriendlyId::Candidates.new(self, normalized_slug || send(friendly_id_config.base))
      slug = slug_generator.generate(candidates) || resolve_friendly_id_conflict(candidates)
      send "#{friendly_id_config.slug_column}=", slug
    end
  end

  private

  def sanitize
    self.name = name.downcase
  end
end
