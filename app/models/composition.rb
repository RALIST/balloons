class Composition < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :items_in_compositions, dependent: :destroy
  has_many :items, through: :items_in_compositions
  has_many :products, through: :items_in_compositions
  has_many :sizes, through: :products
  has_many :carts, through: :positions
  has_many :orders, through: :positions
  has_many :positions
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :receivers

  has_one_attached :image

  VARIANTS = {
    small: { width: 150, height: 150, process: :resize_to_fill},
    medium: { width: 300, height: 300, process: :resize_to_fill },
    large: { width: 800, height: 800, process: :resize_to_limit }
  }

  def missing
    Rails.root.join('app/assets/images/missing_small.png').to_s
  end

  def small_url
    return missing unless image.present?

    process_variant(VARIANTS[:small]).service_url.split('?').first
  end

  def medium_url
    return missing unless image.present?

    process_variant(VARIANTS[:medium]).service_url.split('?').first
  end

  def large_url
    return missing unless image.present?

    process_variant(VARIANTS[:large]).service_url.split('?').first
  end

  def process_variant(variant)
    image.variant(
      variant[:process] => [variant[:width], variant[:height]],
      auto_orient: true,
      strip: true,
      gravity: 'center',
      quality: '100%'
    )
  end

  after_create_commit { ImageProcessingJob.perform_later(id) }

  has_attached_file :img,
                    processors: [:watermark, :thumbnail],
                    styles: {
                        small:
                                             ['x200', :jpg],
                        preview:
                                             ['x350', :jpg],

                        large:
                                             ['x600', :jpg] },
                    convert_options: {
                        all: '-strip -auto-orient'
                    }

  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/webp' ]


  after_save :random_title

  scope :with_items, -> { joins(:products).distinct(:id) }
  scope :without_items, -> {
                          left_outer_joins(:items)
    .where(items_in_compositions: { id: nil }).where(deleted: false).distinct}
  scope :with_tags, -> { joins(:tags).joins(:receivers) }
  scope :without_tags, -> { joins(:products).where.not(id: Composition.with_tags.map(&:id)).where(deleted: false).where('compositions.img_file_size > ?', 0).distinct }
  scope :availible, -> { joins(:image_attachment) }




  def self.with_tag(tag)
    joins(:products, :tags).where('tags.name = ?', tag).distinct(:id)
  end

  def self.with_receivers(receiver)
    joins(:products, :receivers).where('receivers.title = ? ', receiver).distinct(:id)
  end

  def comp_price
    self.products.map { |i| i.price_with_helium }.reject(&:nil?).sum.round(2)
  end

  def update_price
    self.update(price: self.comp_price)
  end

  def tag_name
    tags.each do |tag|
      return tag
    end
  end

  def tag_name=(name)
    name = Unicode.downcase(name.strip)
    tag = Tag.find_or_create_by!(name: name) unless name.blank?
    self.tags << tag
  end

  def receiver_title
    receivers.each do |r|
      return r
    end
  end

  def receiver_title=(title)
    title = Unicode.downcase(title.strip)
    return if  title.blank?

    receiver = Receiver.find_or_create_by!(title: title)
    self.receivers << receiver
  end

  def related
    min = (self.price.to_f - 500)
    max = (self.price.to_f + 500)
    tags = self.tag_ids
    Composition.includes(:tags).availible.where(tags: {id: tags}, price: min..max).where.not(id: self.id).distinct(:id)
  end

  def self.price_range(min, max)
    if min.blank?
      where('compositions.price <= ?', max)
    elsif max.blank?
      where('compositions.price >= ?', min)
    else
      where(compositions: { price: min..max })
    end
  end

  def random_title
    if image.present?
      if self.title.blank?
        tags = self.tags.map { |i| 'на ' + i.name }
        start = ['Букет из воздушных шаров', 'Композиция из воздушных шаров', 'Облако из воздушных шаров', 'Оформление из воздушных шаров', 'Стойка из воздушных шаров', 'Красота из воздушных шаров']
        foil_products = []
        latex_products = []
        self.products.uniq.each do |p|
          case p.type.name
          when 'фольгированные шары'
            foil_products.push(('фольгированный шар' + ' ' + p.foil_form.name).capitalize) if p.foil_form
          when 'латексные шары'
            latex_products.push((p.color.name + ' ' + 'латексный воздушный шар').capitalize)
          end
        end
        receivers = self.receivers.map { |i| i.title }
        products = foil_products + latex_products
        start = start + products
        tags  = tags + receivers
        title = start[rand(start.length)] +
                " #{tags[rand(tags.length)]}"
        self.update(title: title)
      end
    end
  end
end
