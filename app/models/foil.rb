class Foil < Item
  before_save :set_type
  default_scope -> { includes(:type).where(type: Type.find_by(name: 'фольгированные шары')) }

private
  def set_type
    self.type = Type.find_by(name: 'фольгированные шары')
  end
end
