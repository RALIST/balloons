class ItemCreator

  def initialize(item)
    @item = item
  end


  def set_vendor(vendor)
    @item.vendor = vendor
  end

  # def set_size(word)
  #   case vendor
  #   when 'belbal'
  #     sizes = Size.joins(:vendors).where(vendor: 'belbal')
  #   when 'sempertex'
  #     sizes = Size.joins(:vendors).where(vendor: 'sempertex')
  #   when 'gemar'
  #     sizes = Size.joins(:vendors).where(vendor: 'gemar')
  #   end
  # end

  def set_tone(word)
    case vendor
    when 'belbal'
      tones = Tone.joins(:vendors).where(vendor: 'belbal')
    when 'sempertex'
      tones = Tone.joins(:vendors).where(vendor: 'belbal')
    when 'gemar'
      tones = Tone.joins(:vendors).where(vendor: 'belbal')
    end
    unless tone.blank?
      tone = tones.where('code LIKE ?', "%#{word}%")
      @item.tone = tone
    end
  end

  def set_texture(word)
    texture = Texture.where('texture LIKE ?', "%#{word}%").first
    @item.texture = texture
  end

  def compare
    grouped = Item.all.group_by{|item| [item.vendor, item.tone, item.texture]}
  end
end
