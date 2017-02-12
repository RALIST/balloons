class Tone < ApplicationRecord
  belongs_to :color
  has_many :items
  validates :name, presence: true, uniqueness: true
  before_save :sanitize

  private
  def sanitize
    self.name  = name.downcase
    self.eng_name = eng_name.downcase unless eng_name.blank?
  end
end
