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
      xls = Roo::Spreadsheet.open(open('https:' + self.price_sheet.url(:original, false)), extension: :xlsm)
      start_row = 2
      price_vendor = Vendor.find(vendor)
      price_type = Type.find(type) unless type.blank?
      (start_row..xls.last_row).each do |row|
        @product_name = xls.cell(row, 'B').strip.downcase
        @barcode = xls.cell(row, 'C')
        @code = xls.cell(row, 'D')
        @price = xls.cell(row, 'E')
        unless @barcode.blank?
          product = Product.where(barcode: xls.cell(row, 'C').to_i).first_or_initialize do |product|
            case price_type.name
            when 'латексные шары'
              get_latex(@product_name, price_vendor, product)
            when 'фольгированные шары'
            end
          end
        end
      end
    end
  end



  def get_latex(name, vendor, product)
    arr = @product_name.encode("UTF-8").split(/[^а-яА-Я0-9_]/)
    if vendor.name == 'belbal'
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
    puts arr
    arr.each do |word|
      @tone = vendor.tones.find_by(code: word.to_i)
      break if @tone.present?
    end

    arr.each do |word|
      @texture = get_texture(word)
      break if @texture.present?
    end

    if @tone.present? && @texture.present? && @size.present?
      item = Latex.find_or_create_by!(vendor: vendor,
                                      tone: @tone,
                                      texture: @texture) do |i|
        i.category = Category.find_or_create_by!(title: 'без рисунка')
      end
      if item.present?
        product.item = item
        product.size = @size
        product.code = @code
        product.price = @price
        product.name = @product_name
        product.save
      end
    else
      item = Latex.find_or_create_by!(name: @product_name) do |i|
        i.category = Category.find_or_create_by!(title: 'с рисунком')
        i.vendor = vendor
        i.texture = @texture if @texture.present?
      end
      product.size = @size
      product.item = item
      product.code = @code
      product.price = @price
      product.save
    end
  end

  def get_tone(str, vendor)
    unless str.to_i == 0
      tone = vendor.tones.find_by(code: str.to_i)
    end
  end

  def get_color(str)
    color = Color.where('name LIKE ?', "%#{str}%").first
  end

  def get_texture(str)
    texture = Texture.find_by(name: str)
  end

  def get_size(str, vendor)
    unless str.to_i == 0
      size = Size.find_by(in_inch: str.to_i)
    end
  end
end
