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
        Item.create(name: xls.cell(row, 'B').strip.downcase) do |item|
          item.barcode =            xls.cell(row, 'A')
          item.name =               xls.cell(row, 'B').strip.downcase
          item.made_by =            xls.cell(row, 'C')
          item.item_type =          xls.cell(row, 'D')
          item.price =              xls.cell(row, 'E')
          item.size =               xls.cell(row, 'H')
          item.color =              xls.cell(row, 'I')
          item.collection =         xls.cell(row, 'J')
          item.quantity =           xls.cell(row, 'K')
          item.price_with_helium =  xls.cell(row, 'L')
          item.availible_in_comps = xls.cell(row, 'M')
          item.img =                xls.cell(row, 'N')
        end
      end
    end
end
