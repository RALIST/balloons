class Product < ApplicationRecord
  belongs_to :item
  belongs_to :latex, foreign_key: :item_id
  belongs_to :foil, foreign_key: :item_id
  belongs_to :size
  has_many :compositions, through: :items_in_compositions
  has_many :items_in_compositions, dependent: :destroy
  has_many :subpositions, dependent: :delete_all
  has_one :tone, through: :item
  has_one :color, through: :tone
  validates :item_id, :barcode, presence: true
  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  attr_reader :img_remote_url
  before_save :set_price_with_helium

  def self.plain_latex_for_select
    arr = []
    Color.all.find_each do |color|
      items = Latex.joins(:vendor).where(vendors:{name: ['belbal', 'sempertex', 'anagram']}).joins(:tone).joins(:category).where(tones: {color: color})
      if items.any?
        products_arr = []
        if items.any?
          items.map do |item|
            products = item.products.latex_in_compositions
            products.each do |p|
              products_arr.push([p.name, p.id])
            end
          end
        end
        arr.push([color.name, products_arr])
      end
    end
    return arr
  end

  def self.plain_foil_for_select
    arr = []
    FoilForm.all.each do |form|
      items = Foil.where(foil_form: form).joins(:category).where(categories: {title: 'без рисунка'})
      if items.any?
        products_arr = []
        items.map do |item|
          products = item.products.all
          products.each do |product|
            products_arr.push([product.name, product.id])
          end
        end
        arr.push([form.name, products_arr])
      end
    end
    return arr
  end
  def self.printed_foil_for_select
    arr = []
    FoilForm.all.each do |form|
      items = Foil.where(foil_form: form).joins(:category).where(categories: {title: 'с рисунком'})
      if items.any?
        products_arr = []
        items.map do |item|
          products = item.products.all
          products.each do |product|
            products_arr.push([product.name, product.id])
          end
        end
        arr.push([form.name, products_arr])
      end
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
      when 18 || 19 || 20
        self.price_with_helium = 180
      when 36
        self.price_with_helium = 1000
      end
    end
  end


  def self.latex_in_compositions
    joins(latex: :type).joins(:size).where('sizes.in_inch >= ?', 12)
  end

  def foil_in_compositions
    joins(foil: :type)
  end
end
