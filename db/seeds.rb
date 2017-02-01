# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'roo'
require 'nokogiri'


user = User.create(email: 'info@bigairballoons.ru', phone: '79124614168', admin: true, password: 'paduvi30' )

# xls = Roo::Spreadsheet.open('./public/price.xlsm')
# start_row = 1
# end_row = 200
# puts xls.last_row
# (start_row..xls.last_row).each do |row|
#   unless xls.cell(row, 'B').blank?
#     page = Nokogiri::HTML(open(xls.cell(row, 'C')))
#     img_url = 'http://sharik.ru' + page.xpath('//img[@class = "main_image"]/@src').to_s
#     Item.create(
#       name:           xls.cell(row, 'B'),
#       made_by:        xls.cell(row, 'D'),
#       price:          xls.cell(row, 'G'),
#       barcode:        xls.cell(row, 'I'),
#       item_type:      'latex',
#       collection:     xls.cell(row, 'J'),
#       min_order:      xls.cell(row, 'E'),
#       quantity_type:  xls.cell(row, 'F'),
#       img_remote_url: img_url
#       )
#   end
# end

# xls = Roo::Spreadsheet.open('./public/price_foil.xlsm')
# start_row = 1
# end_row = 200
# (start_row..xls.last_row).each do |row|
#   unless xls.cell(row, 'B').blank?
#     page = Nokogiri::HTML(open(xls.cell(row, 'C')))
#     img_url = 'http://sharik.ru' + page.xpath('//img[@class = "main_image"]/@src').to_s
#     Item.create(
#       name:           xls.cell(row, 'B'),
#       made_by:        xls.cell(row, 'D'),
#       price:          xls.cell(row, 'G'),
#       barcode:        xls.cell(row, 'I'),
#       item_type:      'foil',
#       collection:     xls.cell(row, 'J'),
#       min_order:      xls.cell(row, 'E'),
#       quantity_type:  xls.cell(row, 'F'),
#       img_remote_url: img_url
#       )
#   end
# end


# xls = Roo::Spreadsheet.open('./public/price_supplies.xlsm')
# start_row = 1
# end_row = 200
# (start_row..xls.last_row).each do |row|
#   unless xls.cell(row, 'B').blank?
#     page = Nokogiri::HTML(open(xls.cell(row, 'C')))
#     img_url = 'http://sharik.ru' + page.xpath('//img[@class = "main_image"]/@src').to_s
#     Item.create(
#       name:           xls.cell(row, 'B'),
#       made_by:        xls.cell(row, 'D'),
#       price:          xls.cell(row, 'G'),
#       barcode:        xls.cell(row, 'I'),
#       item_type:      'supplies',
#       collection:     xls.cell(row, 'J'),
#       min_order:      xls.cell(row, 'E'),
#       quantity_type:  xls.cell(row, 'F'),
#       img_remote_url: img_url
#       )
#   end
# end
