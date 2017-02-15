class Price < ApplicationRecord
  has_attached_file :price_sheet
  validates_attachment :price_sheet, presence: true,
                        content_type: { content_type: [
                     "application/vnd.ms-excel",
                     "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                   ]
                   },
                   message: ' Only EXCEL files are allowed.'

  after_commit :upload_price


private

  def upload_price
    xls = Roo::Spreadsheet.open(open('https:' + self.price_sheet.url(:original, false)), extension: :xlsm)
    start_row = 2
    count = 1
    (start_row..xls.last_row).each do |row|
      product = Product.find_or_create_by!(barcode: xls.cell(row, 'B').to_i) do |p|
        p.barcode = xls.cell(row, 'C').to_i
        p.code = xls.cell(row, 'D')
        p.price = xls.cell(row, 'E')
        p.quantity = xls.cell(row, 'G')
        name = xls.cell(row, 'B').strip.downcase
        arr = name.split(/\W+/)
        arr.each do |word|
          vendor = Vendor.where('abbr LIKE ?', "%#{word}%").first
          size = vendor.sizes.where('in_cm LIKE ? OR in_inch LIKE ? OR belbal LIKE ?', "%#{word}%", "%#{word}%", "%#{word}%").first
          tone = vendor.tones.where('code LIKE ?', "%#{word}%").first
          texture = Texture.where('name LIKE ?', "%#{word}%").first
          color = Color.where('name LIKE ? OR eng_name LIKE ?', "%#{word}%","%#{word}%").first
        end
        p.size = size
        item = Item.find_or_create_by!(vendor_id: vendor.id,
                                        tone_id: tone.id,
                                        color_id: color.id,
                                        texture_id: texture.id) do |item|
        end
        p.item = item
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
