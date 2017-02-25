class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_many :tags, as: :taggable, dependent: :destroy
  has_and_belongs_to_many :subcategories
  belongs_to :vendor
  belongs_to :type
  belongs_to :tone
  belongs_to :category
  belongs_to :texture
  belongs_to :color
  belongs_to :foil_form
  has_many :sizes, through: :products
  has_many :products, dependent: :destroy

  validates :vendor_id, presence: true
  before_validation :set_collection

  attr_accessor :select_collection, :text_collection
  accepts_nested_attributes_for :products, reject_if: :blank?

  scope :search, -> (query) { where("made_by LIKE ? OR item_type LIKE ? OR collection LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%" )}
  scope :with_price, -> { where.not(price_with_helium: nil) }
  scope :without_collection, -> { where(collection: nil) }
  scope :without_barcode, -> { where(barcode: nil) }
  scope :with_compositions, -> {joins(:compositions)}
  scope :without_compositions, -> {where.not(id: Item.with_compositions.map(&:id))}


  def self.destroy_without_compositions
    self.without_compositions.destroy_all
  end

  def set_collection
    self.collection = Unicode::downcase(select_collection) unless select_collection.blank?
    self.collection = Unicode::downcase(text_collection) unless text_collection.blank?
  end


  private
end
