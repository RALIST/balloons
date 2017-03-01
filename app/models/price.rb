class Price < ApplicationRecord
  has_attached_file :price_sheet
  validates_attachment :price_sheet, presence: true,
                        content_type: { content_type: [
                     "application/vnd.ms-excel",
                     "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                   ]
                   },
                   message: ' Only EXCEL files are allowed.'

  attr_accessor :vendor, :type
  validates :vendor, :type, presence: true
  after_commit :upload_price



  def upload_price
    unless vendor.blank?
      unless Rails.env.development?
        xls = Roo::Spreadsheet.open(open('https:' + self.price_sheet.url(:original, false)), extension: :xlsm)
      else
        xls = Roo::Spreadsheet.open('public' + self.price_sheet.url(:original, false), extension: :xlsm)
      end
      start_row = 1
      price_vendor = Vendor.find_by!(name: vendor)
      price_type = Type.find_by!(name: type) unless type.blank?
      (start_row..xls.last_row).each do |row|
        @product_name = xls.cell(row, 'B').strip.downcase unless xls.cell(row, 'B').blank?
        @barcode = xls.cell(row, 'C') unless xls.cell(row, 'C').blank?
        @code = xls.cell(row, 'D') unless xls.cell(row, 'D').blank?
        @product_price = xls.cell(row, 'E') unless xls.cell(row, 'E').blank?
        @min_order = xls.cell(row, 'F') unless xls.cell(row, 'F').blank?
        @subcategory = xls.cell(row, 'G').strip.downcase unless xls.cell(row, 'G').blank?
        unless @barcode.blank?
          product = Product.where(barcode: xls.cell(row, 'C').to_i).first_or_initialize do |product|
            case price_type.name
            when 'латексные шары'
              get_latex(@product_name, price_vendor, product)
            when 'фольгированные шары'
              vendor_name = xls.cell(row, 'A').strip.downcase unless xls.cell(row, 'A').blank?
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
  end



  def get_latex(name, vendor, product)
    arr = name.encode("UTF-8").split(/[^a-zA-Zа-яА-Я0-9_]/)
    case vendor.name
    when 'belbal' || 'gemar'
      @size = Size.find_by(belbal: arr[1].to_i)
      if @size.present?
        arr.delete(arr[1])
        arr.delete(arr[0])
      else
        arr.each do |word|
          @size = get_size(word, vendor)
          if @size.present?
            arr.delete(word)
            arr.delete(arr[0])
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
      if @tone.present?
        arr.delete(word)
        break
      end
    end

    arr.each do |word|
      @texture = get_texture(word)
      if @texture.present?
        arr.delete(word)
        break
      end
    end

    arr.each do |word|
      @color = get_color(word)
      break if @color.present?
    end

    if @tone.present? && @texture.present? && @size.present?
      @item = Latex.find_or_create_by!(vendor: vendor,
                                      tone: @tone,
                                      texture: @texture) do |item|
        item.category = Category.find_or_create_by!(title: 'без рисунка')
        item.name = arr.join(" ")
        item.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    else
      @item = Latex.find_or_create_by!(name: arr.join(" ")) do |i|
        i.category = Category.find_or_create_by!(title: 'с рисунком')
        i.vendor = vendor
        i.texture = @texture if @texture.present?
        i.name = arr.join(" ")
        i.color = @color
        i.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    end
    if @item.present?
      product.item = @item
      product.size = @size
      product.code = @code
      product.price = @product_price
      product.name = @product_name
      product.min_order = @min_order
      unless @item.tone
        product.set_image
      else
        product.save
      end
    end
  end

  def get_foil(name, product, vendor)
    arr = name.encode("UTF-8").split(/[^a-zA-Zа-яА-Я0-9_]/)
    arr.delete(arr[0])
    arr.each do |word|
      @size = get_size(word, vendor)
      if @size.present?
        arr.delete(word)
        break
      end
    end

    arr.each do |word|
      @tone = get_tone_by_name(word)
      if @tone.present?
        arr.delete(word)
        break
      end
    end

    arr.each do |word|
      @form = get_form(word)
      if @form.present?
        arr.delete(word)
        break
      end
    end

    arr.each do |word|
      @texture = get_texture(word)
      break if @texture.present?
    end

    arr.each do |word|
      @color = get_color(word)
      break if @color.present?
    end

    if @tone.present? && @texture.present? && @form.present?
      @item = Foil.find_or_create_by!(name: arr.join(" ")) do |item|
        item.vendor = vendor
        item.foil_form = @form
        item.texture = @texture
        item.name = arr.join(" ")
        item.tone = @tone
        item.category = Category.find_or_create_by(title: 'без рисунка')
        item.subcategories.push(Subcategory.find_or_create_by!(name: @subcategory))
      end
    else
      @item = Foil.find_or_create_by!(name: arr.join(" ")) do |item|
        item.vendor = vendor
        item.foil_form = @form if @form
        item.texture = @texture if @texture
        item.name = arr.join(" ")
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
      product.name = name
      product.barcode = @barcode
      product.code = @code
      product.price = @product_price
      product.min_order = @min_order
      product.set_image
      product.save
    end
  end

  def get_tone_by_name(str)
    tone = Tone.find_by(name: str)
  end

  def get_tone(str, vendor)
    case vendor.name
    when 'belbal'
      tone = vendor.tones.find_by(code: '%03d' % str)
    when 'gemar'
      tone = vendor.tones.find_by(code: '%02d' % str)
    end
  end

  def get_color(str)
    color = Color.find_by(name: str)
  end

  def get_texture(str)
    texture = Texture.find_by(name: str)
  end

  def get_size(str, vendor)
    unless str.to_i == 0
      size = Size.find_by(in_inch: str.to_i)
    end
  end

  def get_form(str)
    form = FoilForm.find_by(name: str)
  end
end
