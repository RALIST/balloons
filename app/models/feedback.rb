class Feedback < ApplicationRecord
  has_attached_file :img, styles: { preview: ['x300', :png]},
                          convert_options: {
                                            preview: "-quality 75 -strip"},
                          processors: [:thumbnail, :compression],
                          default_url: '/missing/:style/missing.png'
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
end
