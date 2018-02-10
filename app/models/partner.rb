class Partner < ApplicationRecord
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

  validates :logo, presence: true
  has_attached_file :logo, styles: { small:  ['x100', :png],
                                     thumb: ['x300', :png] },
                           convert_options: {
                             small: '-quality 75 -strip',
                             thumb: '-quality 75 -strip'
                           },
                           processors: %i[thumbnail compression]
  validates_attachment_content_type :logo,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']
end
