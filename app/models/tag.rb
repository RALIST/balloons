class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :taggable
  validates :name, presence:  true

  scope :composition_tags, -> { where(taggable_type: 'Composition').select('distinct on (name) * ') }
  def self.dedupe
    grouped = all.group_by{|model| model.name }
    File.open('tmp/tags.txt', 'w+') do |f|
      grouped.values.each do |duplicates|
        first_one = duplicates.shift
        duplicates.each do |double|
          Composition.availible.where('tags.name LIKE ? ', double.name).each do |c|
            f.puts("#{c.id}:#{double.name}")
            double.destroy
          end
        end
      end
    end
    data1 = File.read('app/models/tag.rb')
    data2 = File.read('app/models/composition.rb')
    replace1 = data1.gsub(/has_and_belongs_to_many :compositions/,
                            'has_and_belongs_to_many :compositions')
    replace2 = data2.gsub(/has_many :tags, as: :taggable/,
                          'has_and_belongs_to_many :tags')
    File.open('app/models/tag.rb', 'w'){|file| file.write replace1}
    File.open('app/models/composition.rb', 'w'){|file| file.write replace2}
  end
end
