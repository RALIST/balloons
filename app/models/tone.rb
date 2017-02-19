class Tone < ApplicationRecord
  belongs_to :color
  belongs_to :vendor
  has_many :items
  validates :name, presence: true, uniqueness: true
  before_save :sanitize, :set_image
  has_attached_file :img, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  def sanitize
    self.name  = name.downcase
    self.eng_name = eng_name.downcase unless eng_name.blank?
  end

  def set_image
    unless code.blank? && !self.img.blank?
      if File.exists?("#{Rails.root}/public/#{self.vendor.name}/#{self.code + '.png'}")
        self.img = File.open("#{Rails.root}/public/#{self.vendor.name}/#{self.code + '.png'}")
      end
    end
  end
end
