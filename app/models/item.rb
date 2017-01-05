class Item < ApplicationRecord
  has_many :items_in_composition
  has_many :compositions, through: :items_in_composition
  validates :name, :img, :price, presence: true
  has_attached_file :img
end
