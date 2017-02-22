class Foil < Item
  before_save :set_type

private
  def set_type
    self.type = Type.find_by(name: 'фольгированные шары')
  end
end
