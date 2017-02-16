class Price < ApplicationRecord
  has_attached_file :price_sheet
  validates_attachment :price_sheet, presence: true,
                        content_type: { content_type: [
                     "application/vnd.ms-excel",
                     "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                   ]
                   },
                   message: ' Only EXCEL files are allowed.'
  validates :vendor, presence: true
  attr_accessor :vendor, :type
  after_commit :upload_price


private

  def upload_price
    unless vendor.blank?
      xls = Roo::Spreadsheet.open(open('https:' + self.price_sheet.url(:original, false)), extension: :xlsm)
      start_row = 2
      price_vendor = Vendor.find(vendor) if !vendor.blank?
      price_type = Type.find(type) if !type.blank?
      (start_row..xls.last_row).each do |row|
        name = xls.cell(row, 'B').strip.downcase
        arr = name.encode("UTF-8").split(/[^а-яА-Я0-9_]/)
          arr.each do |word|
            @size = Size.where('in_cm = ? OR in_inch = ? OR belbal = ?', word.to_i, word.to_i, word.to_i).first
            @tone = price_vendor.tones.where('code LIKE ?', "%#{word}%").first
            @texture = Texture.where('name LIKE ?', "%#{word}%").first
            @color = Color.where('name LIKE ?', "%#{word}%").first
          end

          if !@texture.blank? && !@color.blank?
            @item = Item.where(vendor_id: price_vendor.id,
                               texture_id: @texture.id,
                               color_id: @color.id).first_or_create do |item|
              item.vendor = price_vendor
              item.color = @color
              item.texture = @texture
            end
          end
        unless @item.blank?
          product = Product.where(barcode: xls.cell(row, 'B').to_i).first_or_create do |p|
            p.barcode = xls.cell(row, 'C').to_i
            p.code = xls.cell(row, 'D')
            p.price = xls.cell(row, 'E')
            p.quantity = xls.cell(row, 'G')
            p.size = @size
            p.item = @item
          end
        end
      end
      # begin
      #   item = Item.find_by!(name: xls.cell(row, 'B').strip.downcase)
      #   item.update(barcode: xls.cell(row, 'C')) if item.barcode.blank? && !xls.cell(row, 'C').blank?
      #   item.update(code: xls.cell(row, 'D'))
      #   # if item.code.blank? && !xls.cell(row, 'N').blank?
      #   item.update(price: xls.cell(row, 'E')) if !xls.cell(row, 'E').blank?
      # rescue ActiveRecord::RecordNotFound
      #   # Item.create(
      #   #   barcode:            xls.cell(row, 'C'),
      #   #   name:               xls.cell(row, 'B').strip.downcase,
      #   #   code:               xls.cell(row, 'D'),
      #   #   price:              xls.cell(row, 'E')
      #   #   )
      #   next
      # end
    end
  end
end
