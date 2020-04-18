class Color < ApplicationRecord
  has_many :tones
  has_many :items
  has_many :products, through: :items
  before_save :sanitize_name
  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one :image, as: :imageable

  def set_image
    product = Product.includes(:color).where(colors: { id: self.id}).first
    if product.present?
      img_url = product.image(:original)
      self.image = Image.create(img_remote_url: img_url)
    end
  end

  def sanitize_name
    self.name = name.downcase
  end
end
