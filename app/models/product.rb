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
  validates :item_id, :barcode, presence: true, unless: :special?
  validates :barcode, uniqueness: true, unless: :special?

  has_attached_file :img, styles: { small: 'x100', thumb: 'x300' }
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png'],
                                    default_url: '/missing/:style/missing.png'

  attr_reader :img_remote_url
  before_save :set_price_with_helium

  def image(size)
    begin
      if item.tone && type.name != 'фольгированные шары' && type.name != 'товары для композиций' && self.size.in_inch != 36
        item.tone.img.url(size)
      else
        if img.blank?
          if set_image
            img.url(size)
          else
            img.url(size)
          end
        else
          img.url(size)
        end
      end
    rescue
      img = 0
    end
  end

  def complex_name
    case type.name
    when 'латексные шары'
      size_name = "#{size.in_inch.to_i}''(#{size.in_cm.to_i}см) " if size
      tone_name = " #{texture.name} #{tone.name}" if tone
      if size_name && tone_name
        size_name + tone_name
      else
        size_name + item.name
      end
    when 'фольгированные шары'
      size_name = "#{size.in_inch.to_i}''(#{size.in_cm.to_i}см) " if size
      size_name + item.name
    when 'товары для композиций'
      name.capitalize
    end
  end

  def self.plain_latex_for_select
    arr = []
    Color.select(:id, :name).find_each do |color|
      items = Latex.joins(:tone, :vendor)
                   .where(tones: { color_id: color.id }, vendors: { name: %w[belbal sempertex] })
                   .distinct.ids
      if items.any?
        products_arr = []
        if items.any?
          products = joins(:size).where(item_id: items, sizes: { in_inch: 14..36 })
                                 .select(:id, :name, :size_id).order(:size_id)
          products.each do |p|
            products_arr.push([p.name, p.id])
          end
        end
        arr.push([color.name, products_arr])
      end
    end
    arr
  end

  def self.plain_foil_for_select
    arr = []
    FoilForm.select(:id, :name).find_each do |form|
      items = Foil.joins(:category)
                  .where(categories: { title: 'без рисунка' }, foil_form: form)
                  .distinct.ids
      if items.any?
        products_arr = []
        products = includes(:vendor, :size).where(item_id: items)
                                           .where('price_with_helium > ?', 0)
                                           .select(:id, :name, :item_id, :size_id)
        products.find_each do |product|
          if product.size
            products_arr.push(["#{product.vendor.name.capitalize} #{product.size.in_inch.to_i}'' #{product.item.name}", product.id])
          end
        end
        arr.push([form.name, products_arr])
      end
    end
    arr
  end

  def self.printed_foil_for_select
    arr = []
    FoilForm.select(:id, :name).find_each do |form|
      items = Foil.joins(:category)
                  .where(categories: { title: 'с рисунком' }, foil_form: form)
                  .distinct.ids
      if items.any?
        products_arr = []
        products = includes(:size, :vendor).where(item_id: items)
                                           .where('price_with_helium > ?', 0)
                                           .select(:id, :name, :size_id, :item_id)
        products.find_each do |product|
          if product.size
            products_arr.push(["#{product.vendor.name.capitalize} #{product.size.in_inch.to_i}'' #{product.item.name}", product.id])
          end
        end
        arr.push([form.name, products_arr])
      end
    end
    arr
  end

  def self.special_products
    arr = []
    joins(:type).where(types: { name: 'товары для композиций' }).find_each do |p|
      arr.push([p.name, p.id])
    end
    arr
  end

  def img_remote_url=(url)
    self.img = URI.parse(url)
    @img_remote_url = url
  end

  def get_image_from_web
    self.img_remote_url = "http://sharik.ru/images/elements_big/#{code}_m1.jpg" if code.present?
  rescue URI::InvalidURIError
    false
  end

  def set_image
    if code.present? && img.blank?
      if File.exist?("#{Rails.root}/public/300/#{code + '_m1.jpg'}")
        self.img = File.open("#{Rails.root}/public/300/#{code + '_m1.jpg'}")
      else
        get_image_from_web
      end
      save
    end
  end

  def set_price_with_helium
    begin
      if type.name == 'латексные шары' && size.present?
        case size.in_inch
        when 12
          self.price_with_helium = 50
        when 14
          if category.title == 'без рисунка'
            self.price_with_helium = 60
          else
            price.price_with_helium = 80
          end
        when 16
          self.price_with_helium = 80
        when 18
          self.price_with_helium = 120
        when 24
          self.price_with_helium = 450
        when 36
          self.price_with_helium = 900
        end
      else
        if type.name == 'фольгированные шары' && size.present?
          case size.in_inch
          when 18
            self.price_with_helium = 200
          when 19
            self.price_with_helium = 200
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
    rescue => e
      p e
    end
  end

  def self.latex_in_compositions
    joins(:latex, :size, :vendor).where(sizes: { in_inch: [14, 36] }, vendors: { name: %w[belbal sempertex anagram] })
  end

  def self.foil_in_compositions
    joins(:foil, :size).where.not(price_with_helium: nil, sizes: { in_inch: nil }).order(:size_id)
  end

  def self.availible_products
    joins(:size).includes(:item).includes(:type, :tone, :size, :foil_form).where('price_with_helium > ? AND sizes.in_inch >= ?', 0, 12)
  end

  delegate :special?, to: :item
end
