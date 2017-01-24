class Composition < ApplicationRecord
  has_many :items_in_compositions,  dependent: :destroy
  has_many :items, through: :items_in_compositions
  has_many :tags, as: :taggable
  has_many :carts, through: :positions

  validates :title, :img, presence: true
  has_attached_file :img, styles: {small: 'x100',
                                    thumb: 'x300',
                                    large: '1080x1080'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  scope :with_tag, -> (tag) { joins(:tags)
                            .where('tags.name LIKE ?', "%#{tag}%") }
  scope :with_items, -> { joins(:items).distinct(:id)  }
  scope :without_items, -> {left_outer_joins(:items)
                            .where(items_in_compositions: {id: nil})}
  scope :without_price, -> { with_items.where(items: {price_with_helium: nil}).distinct(:id)  }

  scope :availible, -> {joins(:items).where.not(items: {price_with_helium: nil}).distinct(:id) }


  def comp_price
    price = self.items.map{ |i| i.price_with_helium }.reject(&:nil?).sum.round(2)
    self.update(price: price)
  end

  def tag_name
    tags.each do |tag|
      return tag.name
    end
  end

  def tag_name=(name)
    self.tags.find_or_create_by!(name: name) unless name.blank?
  end


end
