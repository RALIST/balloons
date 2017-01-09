class Position < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :composition
  belongs_to :order
  has_many :items, through: :subpositions
  has_many :subpositions, dependent: :destroy


  def sub_exists?(item)
    self.subpositions.where(item_id: item.id).any?
  end

  def add_quantity_to_sub(item, quantity)
    sub = self.subpositions.where(item_id: item.id).last
    sub.update(quantity: sub.quantity.to_i + quantity.to_i)
  end
end
