class Latex < Item
  default_scope -> { where(type: Type.find_by(name: 'латексные шары').id) }
  before_save :set_type
private
  def set_type
    self.type = Type.find_by(name: 'латексные шары')
  end
end
