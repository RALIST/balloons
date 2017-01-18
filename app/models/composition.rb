class Composition < ApplicationRecord
  has_many :items_in_compositions,  dependent: :destroy
  has_many :items, through: :items_in_compositions
  has_many :tags, as: :taggable
  has_many :carts, through: :positions
  validates :title, :img, presence: true
  has_attached_file :img, styles: {small: 'x100', thumb: 'x300', large: '1080x1080'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  scope :with_tag, -> (tag) { joins(:tags).where('tags.name LIKE ?', "%#{tag}%") }

  def comp_price
    price = self.items.map{ |i| i.price }.sum
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
