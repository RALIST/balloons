class Product < ApplicationRecord
  belongs_to :item
  belongs_to :size
  # has_many :compositions, through: :items_in_compositions
  # has_many :items_in_compositions, dependent: :destroy
  has_many :tones, through: :items
  validates :item_id, presence: true




  def self.for_select
    arr = []
    Color.all.each do |color|
      items = Item.joins(:tone).joins(:category).where(tones: {color: color})
      products_arr = []
      if items.any?
        items.map do |item|
          products = item.products.joins(:size).where(sizes: {in_inch: 14})
          products.each do |p|
            products_arr.push([p.name, p.id])
          end
        end
      end
      arr.push([color.name, products_arr])
    end
    return arr
  end

end
