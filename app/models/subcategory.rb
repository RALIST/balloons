class Subcategory < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :products, through: :items
  before_save :sanitize
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :image, as: :imageable

  def self.availible
    joins(items: [:type, :sizes]).where('types.name = ? OR types.name = ?', 'латексные шары', 'фольгированные шары').distinct(:id)
  end

  def set_image
    unless self.image.present?
      img_url = 'https:' + self.products.availible_products.first.image(:original)
      image = Image.create(img_remote_url: img_url)
      self.image = image
    end
  end

  private

  def sanitize
    self.name = name.downcase.strip
  end
end
