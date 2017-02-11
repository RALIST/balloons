class Vendor < ApplicationRecord
  has_many :items
  has_attached_file :logo, styles: {small: 'x100', thumb: 'x300'}
  validates_attachment_content_type :logo,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
end
