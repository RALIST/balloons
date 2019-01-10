class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  attr_reader :img_remote_url
  validates :img, presence: true
  has_attached_file :img, styles: { small:  'x100', thumb: 'x400'},
                          convert_options: {
                            small: '-quality 75 -strip',
                            thumb: '-quality 75 -strip'
                          },
                          processors: %i[thumbnail compression]
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']

  TYPES = %W[\u0432\u0445\u043E\u0434 \u0432\u043D\u0443\u0442\u0440\u0438 \u043F\u0435\u0447\u0430\u0442\u044C].freeze

  def img_remote_url=(url)
    self.img = URI.parse(url)
    @img_remote_url = url
  end
end
