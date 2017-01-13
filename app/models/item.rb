class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :carts, through: :positions, dependent: :delete_all
  has_many :positions, through: :subpositions, dependent: :delete_all
  has_many :subpositions, dependent: :delete_all

  validates :name, :price, presence: true
  has_attached_file :img
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]
  attr_reader :img_remote_url



  def img_remote_url=(url_value)
    self.img = URI.parse(url_value)
    @img_remote_url = url_value
  end
end
