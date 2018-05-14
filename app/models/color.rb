class Color < ApplicationRecord
  has_many :tones
  has_many :items
  has_many :products, through: :items
  before_save :sanitize
  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one :image, as: :imageable

  has_attached_file :img, styles: { small: 'x100', thumb: 'x300' },
                          convert_options: {
                                  small: '-quality 75 -strip  -interlace Plane',
                                  thumb: '-quality 75 -strip -interlace Plane'
                         },
                          processors: [:thumbnail, :paperclip_optimizer]
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png'],
                                    default_url: '/missing/:style/missing.png'

  def set_image
    product = Product.includes(:color).where(colors: { id: self.id}).first
    if product.present?
      img_url = 'https:' + product.image(:original)
      self.image = Image.create(img_remote_url: img_url)
    end
  end


  private

  def sanitize
    self.name = name.downcase
  end
end
