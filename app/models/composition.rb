class Composition < ApplicationRecord
  has_many :items_in_composition
  has_many :items, through: :items_in_composition
  validates :title, :price, :img, presence: true
  has_attached_file :img
end
