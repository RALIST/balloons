class Feedback < ApplicationRecord
  has_attached_file :img, styles: { preview: ['x600', :png]},
                          convert_options: {
                                            large: "-quality 75 -strip",
                                            thumb: "-quality 75 -strip",
                                            preview: "-quality 75 -strip"},
                          processors: [:thumbnail, :compression],
                          default_url: '/missing/:style/missing.png'
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
end
