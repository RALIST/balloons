class Tone < ApplicationRecord
  belongs_to :color
  belongs_to :vendor
  has_many :items
  validates :name, :code, presence: true
  validates :code, uniqueness: { scope: :vendor_id }

  has_attached_file :img, styles: { small: 'x100', thumb: 'x300' }
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']

  before_save :sanitize, :set_image


  def sanitize
    self.name = name.downcase
    self.eng_name = eng_name.downcase if eng_name.present?
  end

  def self.for_select
    arr = []
    Vendor.all.find_each do |vendor|
      tones = Tone.all.order(:code).where(vendor: vendor).uniq(&:code)
      arr.push([vendor.name.capitalize.to_s, tones.map { |t| ["#{t.code}/#{t.name.capitalize}", t.id] }])
    end
    arr
  end

  def set_image

    if !img.present?
      if File.exist?("#{Rails.root}/public/#{vendor.name}/#{code + '.png'}")
        self.img = File.open("#{Rails.root}/public/#{vendor.name}/#{code + '.png'}")
      end
    end
  end
end
