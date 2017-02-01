class Receiver < ApplicationRecord
  belongs_to :personable, polymorphic: true
  validates :title, presence: true
end
