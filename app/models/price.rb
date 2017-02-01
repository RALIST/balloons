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
    (start_row..xls.last_row).each do |row|
        Item.create(
          barcode:            xls.cell(row, 'A'),
          name:               xls.cell(row, 'B').strip,
          made_by:            xls.cell(row, 'C'),
          item_type:          xls.cell(row, 'D'),
          price:              xls.cell(row, 'E'),
          quantity_type:      xls.cell(row, 'F'),
          min_order:          xls.cell(row, 'G'),
          size:               xls.cell(row, 'H'),
          color:              xls.cell(row, 'I'),
          collection:         xls.cell(row, 'J'),
          quantity:           xls.cell(row, 'K'),
          price_with_helium:  xls.cell(row, 'L'),
          availible_in_comps: xls.cell(row, 'M'),
          img:                xls.cell(row, 'N')
          )
      end
    end
end
