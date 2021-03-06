class Position < ApplicationRecord
  belongs_to :cart
  belongs_to :item, optional: true
  belongs_to :composition
  belongs_to :order, optional: true
  has_many :items, through: :subpositions
  has_many :products, through: :subpositions
  has_many :subpositions, dependent: :destroy

  def sub_exists?(product)
    subpositions.where(product_id: product.id).any?
  end

  def add_quantity_to_sub(product, quantity)
    sub = subpositions.where(product_id: product.id).last
    sub.update(quantity: sub.quantity.to_i + quantity.to_i)
  end
end
