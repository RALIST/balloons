class Product < ApplicationRecord
  include Imageable

  belongs_to :item, inverse_of: :products, optional: true
  belongs_to :size, optional: true
  has_many :items_in_compositions
  has_many :compositions, through: :items_in_compositions
  has_many :subpositions, dependent: :delete_all
  has_one :tone, through: :item
  has_one :color, through: :item
  has_one :type, through: :item
  has_one :category, through: :item
  has_one :texture,  through: :item
  has_one :foil_form, through: :item
  has_one :vendor, through: :item
  has_one :category, through: :item
  has_many :subcategories, through: :item
  has_many :carts, through: :subpositions

  has_one_attached :image

  def variants
    {
      small: { width: 100, height: 100, process: :resize_to_fit },
      medium: { width: 200, height: 200, process: :resize_to_fit },
      large: { width: 300, height: 300, process: :resize_to_limit }
    }
  end
  accepts_nested_attributes_for :item

  has_attached_file :img,
                    processors: [:thumbnail],
                    styles: { small: ['x100', :jpg], thumb: ['x250', :jpg]},
                    convert_options: {
                        all: '-compress JPEG2000 -quality 90 -flatten -background white'
                    }
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'],
                                    default_url: '/missing/:style/missing.png'

  attr_reader :img_remote_url
  before_validation :set_complex_name, on: :create

  scope :search, ->(word) { where('lower(products.complex_name) LIKE ? ', "%#{word}%")}

  after_commit { UpdateCompositionsPriceJob.perform_later(id) }


  def in_cart?(cart)
    Rails.cache.fetch("#{self.updated_at}/#{cart.id}"){self.carts.include?(cart)}
  end

  def set_image
    begin
      if tone && size && type.name != 'фольгированные шары' && type.name != 'товары для композиций' && self.size.in_inch != 36
        self.img = tone.img if tone.img.present?
      else
        get_image unless self.img.present?
      end
      save!
    rescue => e
      puts e
      nil
    end
  end

  def set_complex_name
      item_name = self.item.sanitized_name
      size_name = size ?  "#{size.in_inch.to_i}'' (#{size.in_cm.to_i}см) " : ''
      form = foil_form ? " #{foil_form.name}" : ''
      color_name = color ? " #{color.name}" : ''
      texture_name = texture ? " #{texture.name}" : ''
      tone_name = tone ? " #{tone.name}" : ''
      complex_name = 'Шар ' + size_name + form + texture_name + tone_name + item_name
      self.complex_name = complex_name.downcase.capitalize
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
    begin
    self.img = URI.parse(url)
    @img_remote_url = url
    rescue
    end
  end

  def get_image_from_web
    self.img_remote_url = "http://sharik.ru/images/elements_big/#{code}_m1.jpg" if code.present?
  rescue URI::InvalidURIError
    false
  end

  def get_image
    begin
    if code.present? && img.blank?
      if File.exist?("#{Rails.root}/public/300/#{code + '_m1.jpg'}")
        self.img = File.open("#{Rails.root}/public/300/#{code + '_m1.jpg'}")
      else
        get_image_from_web
      end
    end
    rescue => e
      puts e
      nil
    end
  end

  def calc_price_with_helium
    if type.name == 'латексные шары' && size
      self.price_with_helium = size.value
    elsif type.name == 'разное'
      self.price_with_helium = self.price.to_i
    else
      if foil_form && size
        case foil_form.name
          when 'звезда', 'круг', 'сердце', 'квадрат'
            if size.in_inch < 32
              self.price_with_helium = 220
            else
              self.price_with_helium = 499
            end
          when 'цифра'
            self.price_with_helium = 699
          when 'фигура'
            if size.in_inch < 40
              self.price_with_helium =  450
            else
              self.price_with_helium = 550
            end
          when 'ходячая', 'ходячая фигура'
            self.price_with_helium = 2499
        end
      end
    end
  end

  def self.latex_in_compositions
    joins(:latex, :size, :vendor).where(sizes: { in_inch: [14, 36] }, vendors: { name: %w[belbal sempertex anagram] })
  end

  def self.foil_in_compositions
    joins(:foil, :size).where.not(sizes: { in_inch: nil }).order(:size_id)
  end

  def self.availible_products
    left_outer_joins(:size).where('price_with_helium > ? AND sizes.in_inch > ?', 0, 12)
  end

  # delegate :special?, to: :item
end
