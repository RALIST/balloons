class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :img, presence: true
  has_attached_file :img, styles: { small:  ['x100', :png],
                                    thumb: ['x400', :png],
                                    preview: ['x1000', :png] },
                          convert_options: {
                            small: '-quality 75 -strip',
                            thumb: '-quality 75 -strip'
                          },
                          processors: %i[thumbnail compression]
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']

  TYPES = %W[\u0432\u0445\u043E\u0434 \u0432\u043D\u0443\u0442\u0440\u0438 \u043F\u0435\u0447\u0430\u0442\u044C].freeze
end
