class Product < ApplicationRecord
  belongs_to :item
  belongs_to :size
  has_many :compositions, through: :items_in_compositions
  has_many :items_in_compositions, dependent: :destroy
  has_many :tones, through: :items
  validates :item_id, :barcode, presence: true
  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  attr_reader :img_remote_url
  before_save :set_price_with_helium

  def self.for_select
    arr = []
    Color.all.each do |color|
      items = Item.joins(:vendor).where(vendors:{name: ['belbal', 'sempertex', 'anagram']}).joins(:tone).joins(:category).where(tones: {color: color})
      unless items.any?
        items = Item.all.includes(:vendor, :sizes, :products)
      end
      products_arr = []
      if items.any?
        items.map do |item|
          products = item.products.joins(:size).where(sizes: {in_inch: [14, 18, 36]})
          products.each do |p|
            products_arr.push([p.name, p.id])
          end
        end
      end
      arr.push([color.name, products_arr])
    end
    return arr
  end

  def img_remote_url=(url)
    self.img = URI.parse(url)
    @img_remote_url = url
  end

  def get_image_from_web
    begin
      self.img_remote_url = "http://sharik.ru/images/elements_big/#{self.code}_m1.jpg" unless self.code.blank?
    rescue URI::InvalidURIError
      self.img = nil
    end
  end

  def set_image
    unless code.blank?
      if File.exists?("#{Rails.root}/public/300/#{self.code + '_m1.jpg'}")
        self.img = File.open("#{Rails.root}/public/300/#{self.code + '_m1.jpg'}")
      end
    end
  end

  def set_price_with_helium
    if self.size.present?
      case self.size.in_inch
      when 12
        self.price_with_helium = 50
      when 14
        self.price_with_helium = 60
      when 18
        self.price_with_helium = 250
      when 36
        self.price_with_helium = 1000
      end
    end
  end
end
