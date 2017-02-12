class Latex < Item
  default_scope -> { where(type_id: 1) }
  before_save :set_type

private
  def self.set_type
    self.type = Type.find(2)
  end
end
