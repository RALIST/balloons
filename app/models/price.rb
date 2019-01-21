class Price < ApplicationRecord

  has_attached_file :price_sheet
  validates_attachment :price_sheet, presence: true,
                       content_type:           {content_type: [
                                                                  'application/vnd.ms-excel',
                                                                  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                                                              ]},
                       message:                ' Only EXCEL files are allowed.'

  attr_accessor :vendor, :type
  validates :vendor, :type, presence: true
  after_commit :upload_price


  def self.don
    start_time = Time.now
    sizes = 12..36
    items = []
    CSV.foreach("public/prices/Donballon.csv", col_sep: ';', headers: true) do |row|
      next if row[24].blank?

       if row[0] == 'Воздушные шары из латекса'

         if row[29] == 'Sempertex S.A.' && row[24].to_i == 12 && row[1] != 'Линколуны' && row[1] != 'Круглые без рисунка'
           item = {}
           item[:collection] = row[13].split(';')
           item[:category] = row[1]
           item[:category_1] = row[2]
           item[:name] = row[5].split(' ')
           item[:image] = row[11]
           item[:made_by] = row[29]
           items << item
         end

       elsif row[0] == 'Воздушные шары из фольги' && row[24].to_i > 12 && !/мини/.match(row[2].downcase) && row[2] != 'Специальные фигуры' && row[29] != 'Falali'
         item = {}
         item[:category] = row[1]
         item[:category_1] = row[2]
         item[:collection] = row[13].split(';')
         item[:name] = row[5]
         item[:image] = row[11]
         item[:made_by] = row[29]
         items << item

       end

    end
    end_time = Time.now
    puts "***Parsing finished in #{end_time - start_time}***"
    return items
  end

  def self.parse_price
    Dir.glob(File.join('public/prices/**', '*.xlsm')).each do |file|
      xls = Roo::Spreadsheet.open(file, extension: :xlsm)
      (1..xls.last_row).each do |row|
        vendor_name = xls.cell(row, 'A')
        name = xls.cell(row, 'B').strip.downcase unless xls.cell(row, 'B').blank?
        category =  Subcategory.find_or_create_by!(name: xls.cell(row, 'G').downcase) unless xls.cell(row, 'G').blank?
        code = xls.cell(row, 'D')
        if vendor_name.blank? && name.present? && !/ассорти/.match(name)

          Product.find_or_create_by(name: name) do |product|
            vendor = Vendor.find_or_create_by(name: 'belbal')
            get_latex(name, vendor, product, category, code) if name.present?
          end

        else

          # Product.find_or_create_by!(name: name) do |product|
          #
          #   vendor = Vendor.find_or_create_by(name: vendor_name)
          #   get_foil(name, vendor, product, category, code) if name.present?
          #
          # end
        end
      end
    end
    # latex = Roo::Spreadsheet.open("public/belbal.xlsm", extension: :xlsm)
    # foil =  Roo::Spreadsheet.open("public/foil.xlsm", extension: :xlsm)
    #
    # (1..latex.last_row).each do |row|
    #
    #   @product_name  = latex.cell(row, 'B').strip.downcase
    #   @barcode       = latex.cell(row, 'C')
    #   @code          = latex.cell(row, 'D')
    #   @product_price = latex.cell(row, 'E')
    #   @subcategory   = latex.cell(row, 'G')
    #   vendor = Vendor.find_or_create_by(name: 'belbal')
    #   Product.where(name: @product_name).first_or_create do |product|
    #     get_latex(@product_name, vendor, product)
    #   end
    #
    # end
    #
    # (1..foil.last_row).each do |row|
    #   vendor_name = xls.cell(row, 'A').strip.downcase
    #   @product_name  = foil.cell(row, 'B')
    #   @barcode       = foil.cell(row, 'C')
    #   @code          = foil.cell(row, 'D')
    #   @product_price = foil.cell(row, 'E')
    #   @subcategory   = foil.cell(row, 'G').strip.downcase
    #   vendor = Vendor.find_or_create_by(name: vendor_name)
    #   Product.where(name: @product_name).first_or_create do |product|
    #     get_foil(@product_name, vendor, product)
    #   end

    # end

    # start_row    = 1
    # price_vendor = Vendor.find_by(name: vendor)
    # price_type   = Type.find_by!(name: type) if type.present?
    # (start_row .. xls.last_row).each do |row|
    #   @product_name  = xls.cell(row, 'B').strip.downcase if xls.cell(row, 'B').present?
    #   @barcode       = xls.cell(row, 'C') if xls.cell(row, 'C').present?
    #   @code          = xls.cell(row, 'D') if xls.cell(row, 'D').present?
    #   @product_price = xls.cell(row, 'E') if xls.cell(row, 'E').present?
    #   @subcategory   = xls.cell(row, 'G').strip.downcase if xls.cell(row, 'G').present?
    #   Product.where(name: @product_name).first_or_create do |product|
    #     case price_type.name
    #       when 'латексные шары'
    #         get_latex(@product_name, price_vendor, product)
    #       when 'фольгированные шары'
    #         vendor_name = xls.cell(row, 'A').strip.downcase if xls.cell(row, 'A').present?
    #         if vendor_name.present?
    #           @vendor = Vendor.find_or_create_by!(name: vendor_name) do |vendor|
    #             vendor.name = vendor_name
    #           end
    #           get_foil(@product_name, product, @vendor)
    #         end
    #     end
    #   end
    # end
  end

  def self.get_latex(name, vendor, product, category, code)
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


    if @tone.present? && @texture.present? && @size.present? && @size.in_inch > 12
      @item = Latex.find_or_create_by!(vendor:  vendor,
                                       tone:    @tone,
                                       texture: @texture) do |item|
        puts category
        item.category = Category.find_or_create_by(title: 'без рисунка')
        item.name     = arr.join(' ').encode('UTF-8')
        item.subcategories << category if category
      end
    else
      if @size.present? && @size.in_inch >= 12
        @item = Latex.find_or_create_by!(name: arr.join(' ').encode('UTF-8')) do |i|
          i.category = Category.find_or_create_by!(title: 'с рисунком')
          i.vendor   = vendor
          i.texture  = @texture if @texture.present?
          i.name     = arr.join(' ').encode('UTF-8')
          i.color    = @color
          i.subcategories << category if category
        end
      end
    end
    if @item.present?
      product.item      = @item
      product.size      = @size
      product.code      = code
      product.barcode   = @barcode
      product.price     = @product_price
      product.name      = name
    end
  end

  def self.get_foil(name, vendor, product, category, code)
    arr = name.encode('UTF-8').split(/[^a-zA-Zа-яА-Я0-9_]/)

    arr.each do |word|
      @form = get_form(word)
      break if @form.present?
    end
    arr.each do |word|
      if @form && @form.name == 'цифра'
        @size = Size.find_by(in_inch: 40)
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
        item.vendor    = vendor
        item.foil_form = @form
        item.texture   = @texture
        item.name      = arr.join(' ')
        item.tone      = @tone
        item.category  = Category.find_or_create_by(title: 'без рисунка')
        item.subcategories.push(Subcategory.find_or_create_by!(name: category)) if category
      end
    else
      @item = Foil.find_or_create_by!(name: arr.join(' ').encode('UTF-8')) do |item|
        item.vendor    = vendor
        item.foil_form = @form if @form
        item.texture   = @texture if @texture
        item.name      = arr.join(' ').encode('UTF-8')
        item.subcategories.push(Subcategory.find_or_create_by!(name: category)) if category
        if @tone
          item.tone     = @tone
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
      product.name      = name
      product.barcode   = @barcode
      product.code      = code
      product.price     = @product_price
      product.set_image
    end
  end

  def self.get_tone_by_name(str)
    tone = Tone.find_by(name: str)
  end

  def self.get_tone(str, vendor)
    case vendor.name
      when 'belbal'
        tone = vendor.tones.find_by(code: format('%03d', str))
      when 'gemar'
        tone = vendor.tones.find_by(code: format('%02d', str))
    end
  end

  def self.get_color(str)
    color = Color.find_by(name: str)
  end

  def self.get_texture(str)
    texture = Texture.find_by(name: str)
  end

  def self.get_size(str, _vendor)
    size = Size.find_by(in_inch: str.to_i) unless str.to_i == 0
  end

  def self.get_form(str)
    form = FoilForm.find_by(name: str)
  end
end
