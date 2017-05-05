class Receiver < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  belongs_to :personable, polymorphic: true
  validates :title, presence: true
end
