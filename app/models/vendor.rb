class Vendor < ApplicationRecord
  has_many :items
  has_many :tones
  has_attached_file :logo, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :logo,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
  validates :name, presence: true, uniqueness: true
  before_save :sanitize

  private
  def sanitize
    self.name = name.downcase
    self.description = description.downcase unless description.blank?
    self.country = country.downcase unless country.blank?
  end
end
