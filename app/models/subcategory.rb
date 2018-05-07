class Subcategory < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :products, through: :items
  before_save :sanitize
  extend FriendlyId
  friendly_id :name, use: :slugged




  def self.dedupe
    grouped = all.group_by{|model| model.name }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each do |double|
        Item.joins(:subcategories).where('subcategories.name LIKE ? ', double.name).each{|s| s.subcategories << first_one}
        double.destroy
      end
    end
  end

  def set_slug(normalized_slug = nil)
    if should_generate_new_friendly_id?
      candidates = FriendlyId::Candidates.new(self, normalized_slug || send(friendly_id_config.base))
      slug = slug_generator.generate(candidates) || resolve_friendly_id_conflict(candidates)
      send "#{friendly_id_config.slug_column}=", slug
    end
  end

  def resolve_friendly_id_conflict(candidates)
    candidates.first
  end

  def image
  end

  private

  def sanitize
    self.name = name.downcase.strip
  end
end
