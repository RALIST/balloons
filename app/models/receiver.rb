class Receiver < ApplicationRecord
  belongs_to :personable, polymorphic: true
  validates :title, presence: true

  def to_param
    name = Russian::transliterate(self.title)
    [id, name.downcase.split(' ')].join('-')
  end
end
