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
  accepts_nested_attributes_for :products, reject_if: :blank?


  def self.destroy_without_compositions
    self.without_compositions.destroy_all
  end
end
