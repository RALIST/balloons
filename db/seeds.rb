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

vendors = ['belbal', 'gemar', 'sempertex', 'anagram', 'flex metal']
types = ['латексные шары', 'фольгированные шары']
forms = ['звезда', 'круг', 'сердце', 'цифра', 'месяц', 'фигура']
categories = ['с рисунком', 'без рисунка']
textures = ['пастель', 'металлик', 'кристалл', 'перламутр', 'супер', 'фэшн']

forms.each do |form|
  FoilForm.find_or_create_by!(name: form)
end

vendors.each do |vendor|
  Vendor.find_or_create_by!(name: vendor)
end

types.each do |type|
  Type.find_or_create_by!(name: type)
end

categories.each do |category|
  Category.find_or_create_by!(title: category)
end

textures.each do |texture|
  Texture.find_or_create_by!(name: texture)
end

xls = Roo::Spreadsheet.open('public/Размеры.xlsm', extension: :xlsm)
start_row = 2
(start_row..xls.last_row).each do |row|
  size = Size.find_or_create_by(in_inch: xls.cell(row, 'B')) do |size|
    size.in_cm = xls.cell(row, 'A') unless xls.cell(row, 'A').blank?
    size.in_inch = xls.cell(row, 'B')
    size.belbal = xls.cell(row, 'C') unless xls.cell(row, 'C').blank?
  end
end

xls = Roo::Spreadsheet.open('public/Цвета.xlsm', extension: :xlsm)
start_row = 2
(start_row..xls.last_row).each do |row|
  vendor = Vendor.find_by(name: xls.cell(row, 'A').strip.downcase)
  case vendor.name
  when 'belbal' || 'sempertex'
    code = '%03d' % xls.cell(row, 'B')
  when 'gemar'
    code = '%02d' % xls.cell(row, 'B')
  end
  name = xls.cell(row, 'C')
  color = Color.find_or_create_by!(name: xls.cell(row, 'E'))
  if vendor.present? && code.present? && name.present?
    tone = Tone.find_or_create_by(vendor: vendor, name: name, color: color, code: code)
  end
end
