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
  has_one :type, through: :item
  has_one :category, through: :item
  has_one :texture,  through: :item
  has_one :foil_form, through: :item
  has_one :vendor, through: :item
  has_many :subcategories, through: :item
  validates :item_id, :barcode, presence: true
  validates :barcode, uniqueness: true

  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  attr_reader :img_remote_url
  before_save :set_price_with_helium


  def self.plain_latex_for_select
    arr = []
    Color.all.select(:id, :name).find_each do |color|
      items = Latex.joins(:tone).includes(:products).where(tones: {color_id: color.id}).select(:id, :type_id).distinct
      if items.any?
        products_arr = []
        if items.any?
          items.each do |item|
            products = latex_in_compositions.where(item_id: item.id).select(:id, :name, :size_id).order(:size_id)
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
    FoilForm.all.select(:id, :name).find_each do |form|
      items = Foil.joins(:category).includes(:products, :vendor).where(categories: {title: 'без рисунка'}, foil_form: form).select(:id, :vendor_id).distinct
      if items.any?
        products_arr = []
        items.each do |item|
          products = foil_in_compositions.where(item_id: item.id).distinct.select(:id, :name, :size_id, :item_id)
          products.each do |product|
            if product.size
              products_arr.push(["#{product.vendor.name.capitalize} #{product.size.in_inch.to_i}'' #{product.item.name}", product.id])
            end
          end
        end
        arr.push([form.name, products_arr])
      end
    end
    return arr
  end

  def self.printed_foil_for_select
    arr = []
    FoilForm.all.select(:id, :name).find_each do |form|
      items = Foil.joins(:category).includes(:products, :vendor, :foil_form).where(categories: {title: 'с рисунком'}, foil_form_id: form.id).select(:id, :vendor_id, :foil_form_id).distinct
      if items.any?
        products_arr = []
        items.each do |item|
          products = foil_in_compositions.where(item_id: item.id).select(:id, :name, :size_id, :item_id)
          products.each do |product|
            if product.size
              products_arr.push(["#{product.vendor.name.capitalize} #{product.size.in_inch.to_i}'' #{product.item.name}", product.id])
            end
          end
        end
        arr.push([form.name, products_arr])
      end
    end
    return arr
  end

  def self.special_products
    arr = []
    joins(:type).where(types: {name: 'товары для композиций'}).each do |p|
      arr.push([p.name, p.id])
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
      false
    end
  end

  def set_image
    if !code.blank? && img.blank?
      if File.exists?("#{Rails.root}/public/300/#{self.code + '_m1.jpg'}")
        self.img = File.open("#{Rails.root}/public/300/#{self.code + '_m1.jpg'}")
      else
        self.get_image_from_web
      end
      self.save
    end
  end

  def set_price_with_helium
    if self.price_with_helium.blank?
      if self.type.name == 'латексные шары' && self.size.present?
        case self.size.in_inch
        when 12
          self.price_with_helium = 50
        when 14
          self.price_with_helium = 60
        when 16
          self.price_with_helium = 80
        when 18
          self.price_with_helium = 120
        when 24
          self.price_with_helium = 400
        when 36
          self.price_with_helium = 900
        end
      else
        if self.type.name == 'фольгированные шары' && self.size.present?
          case self.size.in_inch
          when 18
            self.price_with_helium = 180
          when 19
            self.price_with_helium = 180
          when 30
            self.price_with_helium = 450
          when 32
            self.price_with_helium = 450
          when 36
            self.price_with_helium = 700
          when 40
            self.price_with_helium = 700
          end
        end
      end
    end
  end


  def self.latex_in_compositions
    joins(:latex, :size, :vendor).where(sizes: { in_inch: [14,36] }, vendors: { name: ['belbal', 'sempertex', 'anagram'] })
  end

  def self.foil_in_compositions
    joins(:foil, :size).where.not(price_with_helium: nil, sizes: {in_inch: nil}).order(:size_id)
  end
end
