class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_and_belongs_to_many :subcategories
  belongs_to :vendor
  belongs_to :type
  belongs_to :tone
  belongs_to :category
  belongs_to :texture
  belongs_to :color
  belongs_to :foil_form
  has_many :sizes, through: :products
  has_many :products, dependent: :destroy, autosave: true

  validates :vendor_id, :type_id, presence: true, if: -> {self.not_special?}
  accepts_nested_attributes_for :products

  scope :search, ->(word) { where('name LIKE ? ', "%#{word}%").distinct }
  scope :special, -> { joins(:type).where(types: { name: 'разное' }) }

  def not_special?
    !type.name == 'разное'
  end

  def set_color
    self.color = self.tone.color if self.tone
    self.save
  end

  def sanitized_name
    form = self.foil_form.name if foil_form
    color = Color.all.pluck(&:name).join("|")
    texture = Texture.all.pluck(&:name).join('|')
    name.downcase.gsub(/\b#{form}\b|\b\S{2,2}\b|[[:punct:]]|\S{0,3}[[:digit:]]|#{color}|#{texture}|\bшар\b|\bily\b|\bм\b/, ' ')
  end

end
