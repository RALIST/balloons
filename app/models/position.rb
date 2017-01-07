class Position < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :composition
  has_many :items, through: :subpositions
  has_many :subpositions, dependent: :destroy
end
