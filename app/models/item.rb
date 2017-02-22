class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :positions, through: :subpositions, dependent: :delete_all
  has_many :subpositions, dependent: :delete_all
  has_and_belongs_to_many :subcategories
  belongs_to :vendor
  belongs_to :type
  belongs_to :tone
  belongs_to :category
  belongs_to :texture
  belongs_to :color
  belongs_to :foil_form
  has_many :sizes, through: :products
  has_many :products

  validates :vendor_id, presence: true
  before_validation :set_collection
  before_save :sanitize_params

  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
  attr_accessor :select_collection, :text_collection
  accepts_nested_attributes_for :products, reject_if: :blank?

  scope :search, -> (query) { where("made_by LIKE ? OR item_type LIKE ? OR collection LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%" )}
  scope :with_price, -> { where.not(price_with_helium: nil) }
  scope :without_collection, -> { where(collection: nil) }
  scope :without_img, -> { where(img_file_name: nil) }
  scope :without_barcode, -> { where(barcode: nil) }
  scope :comp_availible, -> { where(availible_in_comps: true) }
  scope :with_img, -> { where.not(img_file_name: nil)}




  def set_collection
    self.collection = Unicode::downcase(select_collection) unless select_collection.blank?
    self.collection = Unicode::downcase(text_collection) unless text_collection.blank?
  end


  private
  def sanitize_params
    self.barcode = Unicode.downcase(barcode) unless barcode.blank?
    self.name = Unicode::downcase(name) unless name.blank?
    self.made_by = Unicode::downcase(made_by) unless made_by.blank?
    self.item_type = Unicode::downcase(item_type) unless item_type.blank?
  end
end
