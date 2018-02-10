class Latex < Item
  default_scope -> { includes(:type).where(type: Type.find_by(name: 'латексные шары')) }
  before_save :set_type

  private

  def set_type
    self.type = Type.find_by(name: 'латексные шары')
  end
end
