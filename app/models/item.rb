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

  validates :vendor_id, :type_id, presence: true
  validates :name, uniqueness: true, unless: :special
  accepts_nested_attributes_for :products, reject_if: :blank?

  scope :search, -> (word){where('name LIKE ? ', "%#{word}%").distinct}
  scope :special, -> {joins(:type).where(types:{name: 'товары для композиций'})}
end
