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


user = User.create(email: 'info@bigairballoons.ru',
                    phone: '79124614168',
                    admin: true,
                    password: 'paduvi30',
                    first_name: 'admin' )

xls = Roo::Spreadsheet.open('public/Цвета.xlsm', extension: :xlsm)
start_row = 2
(start_row..xls.last_row).each do |row|
  vendor = Vendor.find_by(name: xls.cell(row, 'A').strip.downcase)
  code = xls.cell(row, 'B')
  name = xls.cell(row, 'C')
  color = Color.find_or_create_by!(name: xls.cell(row, 'E'))
  if vendor.present? && code.present? && name.present?
    tone = Tone.create(vendor: vendor, name: name, color: color, code: code)
  end
end

xls = Roo::Spreadsheet.open('public/Размеры.xlsm', extension: :xlsm)
start_row = 2
(start_row..xls.last_row).each do |row|
  in_cm = xls.cell(row, 'A')
  in_inch = xls.cell(row, 'B')
  belbal = xls.cell(row, 'C')
  size = Size.create(in_cm: in_cm, in_inch: in_inch, belbal: belbal)
end
