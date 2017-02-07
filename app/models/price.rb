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
      begin
        item = Item.find_by!(name: xls.cell(row, 'B').strip.downcase)
        item.update(barcode: xls.cell(row, 'C')) if item.barcode.blank? && !xls.cell(row, 'C').blank?
        item.update(code: xls.cell(row, 'D'))
        # if item.code.blank? && !xls.cell(row, 'N').blank?
        item.update(price: xls.cell(row, 'E')) if !xls.cell(row, 'E').blank?
      rescue ActiveRecord::RecordNotFound
        # Item.create(
        #   barcode:            xls.cell(row, 'C'),
        #   name:               xls.cell(row, 'B').strip.downcase,
        #   code:               xls.cell(row, 'D'),
        #   price:              xls.cell(row, 'E')
        #   )
        next
      end
    end
  end
end
