class Subcategory < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :products, through: :items
  before_save :sanitize
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :image, as: :imageable

  after_find :set_image

  def self.availible
    joins(items: [:type, :sizes]).where('types.name = ? OR types.name = ?', 'латексные шары', 'фольгированные шары').distinct(:id)
  end

  def set_image
    unless self.image
      self.image = Image.create do |image|
        image.img_remote_url = self.products.first.image(:original) if self.products.any?
      end
    end
  end

  private

  def sanitize
    self.name = name.downcase.strip
  end
end
