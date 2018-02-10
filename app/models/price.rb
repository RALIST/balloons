class Price < ApplicationRecord
  has_attached_file :price_sheet
  validates_attachment :price_sheet, presence: true,
                                     content_type: { content_type: [
                                       'application/vnd.ms-excel',
                                       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                                     ] },
                                     message: ' Only EXCEL files are allowed.'

  attr_accessor :vendor, :type
  validates :vendor, :type, presence: true
  after_commit :upload_price

  def upload_price
    if vendor.present?
      if Rails.env.development?
        xls = Roo::Spreadsheet.open('public' + price_sheet.url(:original, false), extension: :xlsm)
      else
        xls = Roo::Spreadsheet.open(open('https:' + price_sheet.url(:original, false)), extension: :xlsm)
      end
      start_row = 1
      price_vendor = Vendor.find_by(name: vendor)
      price_type = Type.find_by!(name: type) if type.present?
      (start_row..xls.last_row).each do |row|
        @product_name = xls.cell(row, 'B').strip.downcase if xls.cell(row, 'B').present?
        @barcode = xls.cell(row, 'C') if xls.cell(row, 'C').present?
        @code = xls.cell(row, 'D') if xls.cell(row, 'D').present?
        @product_price = xls.cell(row, 'E') if xls.cell(row, 'E').present?
        @min_order = xls.cell(row, 'F') if xls.cell(row, 'F').present?
        @subcategory = xls.cell(row, 'G').strip.downcase if xls.cell(row, 'G').present?
        next if @barcode.blank?
        Product.where(barcode: xls.cell(row, 'C').to_i).first_or_create do |product|
          case price_type.name
          when 'латексные шары'
            get_latex(@product_name, price_vendor, product)
          when 'фольгированные шары'
            vendor_name = xls.cell(row, 'A').strip.downcase if xls.cell(row, 'A').present?
            if vendor_name.present?
              @vendor = Vendor.find_or_create_by!(name: vendor_name) do |vendor|
                vendor.name = vendor_name
              end
              get_foil(@product_name, product, @vendor)
            end
          end
        end
      end
    end
  end

  def get_latex(name, vendor, product)
    arr = name.encode('UTF-8').split(/[^a-zA-Zа-яА-Я0-9_]/)
    case vendor.name
    when 'belbal' || 'gemar'
      @size = Size.find_by(belbal: arr[1].to_i)
      if @size.present?
        arr.delete(arr[1])
      else
        arr.each do |word|
          @size = get_size(word, vendor)
          if @size.present?
            arr.delete(word)
            break
          end
        end
      end
    else
      arr.each do |word|
        @size = get_size(word, vendor)
        if @size.present?
          arr.delete(word)
          break
        end
      end
    end
    arr.each do |word|
      @tone = Tone.find_by(code: word, vendor: vendor)
      break if @tone.present?
    end

    arr.each do |word|
      @texture = get_texture(word)
      break if @texture.present?
    end

    arr.each do |word|
      @color = get_color(word)
      break if @color.present?
    end
    arr.delete(arr[0])
    if @tone.present? && @texture.present? && @size.present?
      @item = Latex.find_or_create_by!(vendor: vendor,
                                       tone: @tone,
                                       texture: @texture) do |item|
        item.category = Category.find_or_create_by!(title: 'без рисунка')
        item.name = arr.join(' ').encode('UTF-8')
        item.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    else
      @item = Latex.find_or_create_by!(name: arr.join(' ').encode('UTF-8')) do |i|
        i.category = Category.find_or_create_by!(title: 'с рисунком')
        i.vendor = vendor
        i.texture = @texture if @texture.present?
        i.name = arr.join(' ').encode('UTF-8')
        i.color = @color
        i.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    end
    if @item.present?
      product.item = @item
      product.size = @size
      product.code = @code
      product.barcode = @barcode
      product.price = @product_price
      product.name = @product_name
      product.min_order = @min_order
      product.set_image unless @item.tone
    end
  end

  def get_foil(name, product, vendor)
    arr = name.encode('UTF-8').split(/[^a-zA-Zа-яА-Я0-9_]/)

    arr.each do |word|
      @form = get_form(word)
      break if @form.present?
    end
    arr.each do |word|
      if @form && @form.name == 'цифра'
        @size = Size.where('in_inch >= ?', 14).find_by(in_inch: word.to_i)
        if @size.present?
          arr.delete(word)
          break
        end
      else
        @size = get_size(word, vendor)
        if @size.present?
          arr.delete(word)
          break
        end
      end
    end

    arr.each do |word|
      @tone = get_tone_by_name(word)
      break if @tone.present?
    end

    arr.each do |word|
      @texture = get_texture(word)
      break if @texture.present?
    end

    arr.each do |word|
      @color = get_color(word)
      break if @color.present?
    end
    arr.delete(arr[0])
    if @tone.present? && @texture.present? && @form.present?
      @item = Foil.find_or_create_by!(name: arr.join(' ').encode('UTF-8')) do |item|
        item.vendor = vendor
        item.foil_form = @form
        item.texture = @texture
        item.name = arr.join(' ')
        item.tone = @tone
        item.category = Category.find_or_create_by(title: 'без рисунка')
        item.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    else
      @item = Foil.find_or_create_by!(name: arr.join(' ').encode('UTF-8')) do |item|
        item.vendor = vendor
        item.foil_form = @form if @form
        item.texture = @texture if @texture
        item.name = arr.join(' ').encode('UTF-8')
        item.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
        if @tone
          item.tone = @tone
          item.category = Category.find_or_create_by(title: 'без рисунка')
        else
          item.category = Category.find_or_create_by(title: 'с рисунком')
        end
      end
    end
    if @item.present?
      product.item = @item
      product.size = @size if @size.present?
      if @form.present? && @form.name == 'цифра' && @size.blank?
        product.size = Size.find_by(in_inch: 40)
      end
      product.name = name
      product.barcode = @barcode
      product.code = @code
      product.price = @product_price
      product.min_order = @min_order
      product.set_image
    end
  end

  def get_tone_by_name(str)
    tone = Tone.find_by(name: str)
  end

  def get_tone(str, vendor)
    case vendor.name
    when 'belbal'
      tone = vendor.tones.find_by(code: format('%03d', str))
    when 'gemar'
      tone = vendor.tones.find_by(code: format('%02d', str))
    end
  end

  def get_color(str)
    color = Color.find_by(name: str)
  end

  def get_texture(str)
    texture = Texture.find_by(name: str)
  end

  def get_size(str, _vendor)
    size = Size.find_by(in_inch: str.to_i) unless str.to_i == 0
  end

  def get_form(str)
    form = FoilForm.find_by(name: str)
  end
end
