class Composition < ApplicationRecord
  has_many :items_in_compositions,  dependent: :destroy
  has_many :items, through: :items_in_compositions
  has_many :products, through: :items_in_compositions
  has_many :sizes, through: :products
  has_many :tags, as: :taggable
  has_many :carts, through: :positions
  has_many :receivers, as: :personable

  validates :img, presence: true
  has_attached_file :img, styles: {small:  ['x100', :png],
                                    thumb: ['x300', :png],
                                    preview: ['x600', :png],
                                    large: ['x1080', :png]},
                          processors: [:thumbnail, :paperclip_optimizer],
                          paperclip_optimizer: {
                            optipng: {level: 7}
                          }
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  scope :with_tag, -> (tag) { joins(:tags)
                            .where('tags.name LIKE ?', "%#{tag}%").distinct(:id) }
  scope :with_items, -> { joins(:products).distinct(:id)  }
  scope :without_items, -> {left_outer_joins(:items)
                            .where(items_in_compositions: {id: nil}).where(deleted: false)}
  scope :without_price, -> { with_items.where(products: {price_with_helium: nil}).distinct(:id)  }
  scope :with_tags, -> {joins(:tags).joins(:receivers)}
  scope :without_tags, ->{ where.not(id: Composition.with_tags.map(&:id)).where(deleted: false) }
  scope :availible, -> {includes(:tags).joins(:products).distinct(:id).where.not(id: Composition.without_price.map(&:id), deleted: true)}
  scope :with_receivers, -> (receiver) { joins(:receivers).where(receivers: {title: receiver})}

  def comp_price
    price = self.products.map{ |i| i.price_with_helium }.reject(&:nil?).sum.round(2)
    self.update(price: price)
  end

  def update_price
      self.comp_price
  end

  def tag_name
    tags.each do |tag|
      return tag.name
    end
  end

  def tag_name=(name)
    name = Unicode::downcase(name.strip)
    self.tags.find_or_create_by!(name: name) unless name.blank?
  end

  def receiver_title
    receivers.each do |r|
      return r.title
    end
  end

  def receiver_title=(title)
    title = Unicode::downcase(title.strip)
    self.receivers.find_or_create_by!(title: title) unless title.blank?
  end

  def related
    min = (self.price.to_f - 1000)
    max = (self.price.to_f + 1000)
    Composition.availible.where(price: min..max).includes(:tags)
                        .where(tags: {name: self.tags.map(&:name)})
                        .where.not(id: self.id)
  end

  def self.price_range(min, max)
    if min.blank?
      where('compositions.price <= ?', max)
    elsif max.blank?
      where('compositions.price >= ?', min)
    else
      where(compositions: {price: min..max})
    end
  end

end
