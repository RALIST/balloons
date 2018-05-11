class Subcategory < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :products, through: :items
  before_save :sanitize
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :img, styles: { small: 'x100', thumb: 'x300' },
                          convert_options: {
                                  small: '-quality 75 -strip  -interlace Plane',
                                  thumb: '-quality 75 -strip -interlace Plane'
                         },
                          processors: [:thumbnail, :paperclip_optimizer]
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']

  def self.availible
    joins(items: [:type, :sizes]).where('types.name = ? OR types.name = ?', 'латексные шары', 'фольгированные шары').distinct(:id)
  end

  def set_image
    unless self.img.present?
      img_url = 'https:' + self.products.availible_products.first.image(:original)
      self.img = URI.parse(img_url)
      self.save
    end
  end

  private

  def sanitize
    self.name = name.downcase.strip
  end
end
