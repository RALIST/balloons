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


xls = Roo::Spreadsheet.open('./public/price.xlsm')
start_row = 21
end_row = 1937
(start_row..end_row).each do |row|
  unless xls.cell(row, 'B').blank?
    page = Nokogiri::HTML(open(xls.cell(row, 'C')))
    img_url = 'http://sharik.ru' + page.xpath('//img[@class = "main_image"]/@src').to_s
    Item.create(
      name:     xls.cell(row, 'B'),
      made_by:  xls.cell(row, 'D'),
      price:    xls.cell(row, 'G'),
      barcode:  xls.cell(row, 'I'),
      img_remote_url: img_url
      )
    puts "Latex Added"
  end
end

xls = Roo::Spreadsheet.open('./public/price_foil.xlsm')
start_row = 21
end_row = 2879
(start_row..end_row).each do |row|
  unless xls.cell(row, 'B').blank?
    page = Nokogiri::HTML(open(xls.cell(row, 'C')))
    img_url = 'http://sharik.ru' + page.xpath('//img[@class = "main_image"]/@src').to_s
    Item.create(
      name:     xls.cell(row, 'B'),
      made_by:  xls.cell(row, 'D'),
      price:    xls.cell(row, 'G'),
      barcode:  xls.cell(row, 'I'),
      img_remote_url: img_url
      )
    puts "Foil Added"
  end
end
