class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :img, presence: true
  has_attached_file :img, styles: {small:  ['x100', :png],
                                    thumb: ['x400', :png],
                                    preview: ['x1000', :png]},
                          convert_options: {
                                            small: "-quality 75 -strip",
                                            thumb: "-quality 75 -strip"},
                          processors: [:thumbnail, :compression]
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]


  TYPES = ['вход', 'внутри', 'печать' ]
end
