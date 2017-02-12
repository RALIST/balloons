class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :positions, through: :subpositions, dependent: :delete_all
  has_many :subpositions, dependent: :delete_all
  belongs_to :vendor
  belongs_to :type
  belongs_to :tone
  belongs_to :category
  belongs_to :texture
  has_many :sizes, through: :item_sizes


  before_validation :set_collection
  before_save :sanitize_params

  validates :name, presence: true, uniqueness: true
  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
  attr_reader :img_remote_url
  attr_accessor :select_collection, :text_collection

  scope :search, -> (query) { where("made_by LIKE ? OR item_type LIKE ? OR collection LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%" )}
  scope :with_price, -> { where.not(price_with_helium: nil) }
  scope :without_collection, -> { where(collection: nil) }
  scope :without_img, -> { where(img_file_name: nil) }
  scope :without_barcode, -> { where(barcode: nil) }
  scope :comp_availible, -> { where(availible_in_comps: true) }
  scope :with_img, -> { where.not(img_file_name: nil)}

  def img_remote_url=(url)
    self.img = URI.parse(url)
    @img_remote_url = url
  end

  def set_collection
    self.collection = Unicode::downcase(select_collection) unless select_collection.blank?
    self.collection = Unicode::downcase(text_collection) unless text_collection.blank?
  end

  def self.for_select
    collections = Item.all.map(&:collection).reject(&:blank?).uniq
    collections.map do |collection|
      items = self.where(collection: collection).reject(&:blank?)
      [
        collection, items.map{|i| [i.name, i.id]}
      ]
    end
  end

  def self.destroy_duplicates
    grouped = all.group_by{|item| [item.name, item.barcode]}
    grouped.values.each do |duplicates|
      first = duplicates.shift
      duplicates.each{|double| double.destroy}
    end
  end

  def self.get_images
    Item.where(img_file_name: nil).find_each(batch_size: 500) do |item|
      begin
        item.img_remote_url = "http://sharik.ru/images/elements_big/#{item.code}_m1.jpg" unless item.code.blank?
        item.save
      rescue URI::InvalidURIError
        next
      end
    end
  end

  private
  def sanitize_params
    self.barcode = Unicode.downcase(barcode) unless barcode.blank?
    self.name = Unicode::downcase(name) unless name.blank?
    self.made_by = Unicode::downcase(made_by) unless made_by.blank?
    self.item_type = Unicode::downcase(item_type) unless item_type.blank?
  end
end
