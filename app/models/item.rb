class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_and_belongs_to_many :subcategories,
                          after_add: :touch_updated_at,
                          after_remove: :touch_updated_at
  belongs_to :vendor
  belongs_to :type
  belongs_to :tone
  belongs_to :category
  belongs_to :texture
  belongs_to :color
  belongs_to :foil_form
  has_many :sizes, through: :products
  has_many :products, dependent: :destroy, autosave: true

  validates :type_id, presence: true

  attr_accessor :products_attributes
  accepts_nested_attributes_for :products, reject_if: :all_blank

  scope :search, ->(word) { where('name LIKE ? ', "%#{word}%").distinct }
  scope :special, -> { joins(:type).where(types: { name: 'разное' }) }

  def touch_updated_at(subcategory)
   subcategory.touch
  end

  def not_special?
    !type.name == 'разное'
  end

  def set_color
    self.color = self.tone.color if self.tone
    self.save
  end

  def sanitized_name
    form = foil_form ? self.foil_form.name : ""
    color_name =  color ? self.color.name : ""
    texture_name = texture ? self.texture.name : ""
    sanitized = self.name.present? ? name.downcase.gsub(/\b[[:digit:]][а-я]{,3}\b|[[:digit:]]|[[:punct:]]|\b[а-я]{2}\b|\bшар\b|\bily\b|\bм\b|\bшар\b|\b[a-z]{1}[[:digit:]]{,2}\b/, '') : ''
    sanitized = sanitized.gsub(/#{form}/, '') if form
    sanitized = sanitized.gsub(/#{color_name}/, '') if color_name
    sanitized = sanitized.gsub(/#{texture_name}/, '') if texture_name
    sanitized
  end

end
