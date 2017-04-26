class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').distinct}


  def to_param
    name = Russian::transliterate(self.name)
    [id, name.downcase.split(' ')].join('-')
  end
end
