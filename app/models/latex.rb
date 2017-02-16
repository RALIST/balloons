class Latex < Item
  # default_scope -> { joins(:type).where(type: {name: 'латексные шары'}) }
  # before_save :set_type
  # Добавить references
private
  # def set_type
  #   self.type = Type.find_by(name: 'латексные шары')
  # end
end
