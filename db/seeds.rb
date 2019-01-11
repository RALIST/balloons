
require 'open-uri'
require 'nokogiri'
require 'roo'

user = User.find_or_create_by!(email: 'admin@admin.ru') do |user|
  user.phone = '+7(999) 999 99 99',
               user.admin = true,
               user.password = 'admin'
  user.first_name = 'admin'
  user.last_name = 'admin'
end

vendors = ['belbal', 'gemar', 'sempertex', 'anagram', 'flex metal']
types = ['латексные шары', 'фольгированные шары']
forms = %W[\u0437\u0432\u0435\u0437\u0434\u0430 \u043A\u0440\u0443\u0433 \u0441\u0435\u0440\u0434\u0446\u0435 \u0446\u0438\u0444\u0440\u0430 \u043C\u0435\u0441\u044F\u0446 \u0444\u0438\u0433\u0443\u0440\u0430 ходячая]
categories = ['с рисунком', 'без рисунка']
textures = %W[\u043F\u0430\u0441\u0442\u0435\u043B\u044C \u043C\u0435\u0442\u0430\u043B\u043B\u0438\u043A \u043A\u0440\u0438\u0441\u0442\u0430\u043B\u043B \u043F\u0435\u0440\u043B\u0430\u043C\u0443\u0442\u0440 \u0441\u0443\u043F\u0435\u0440 \u0444\u044D\u0448\u043D]

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
    size.in_cm = xls.cell(row, 'A') if xls.cell(row, 'A').present?
    size.in_inch = xls.cell(row, 'B')
    size.belbal = xls.cell(row, 'C') if xls.cell(row, 'C').present?
  end
end

xls = Roo::Spreadsheet.open('public/Цвета.xlsm', extension: :xlsm)
start_row = 2
(start_row..xls.last_row).each do |row|
  vendor = Vendor.find_by(name: xls.cell(row, 'A').strip.downcase)
  case vendor.name
  when 'belbal' || 'sempertex'
    code = format('%03d', xls.cell(row, 'B'))
  when 'gemar'
    code = format('%02d', xls.cell(row, 'B'))
  end
  name = xls.cell(row, 'C')
  color = Color.find_or_create_by!(name: xls.cell(row, 'E'))
  if vendor.present? && code.present? && name.present?
    tone = Tone.find_or_create_by(vendor: vendor, name: name, color: color, code: code)
  end
end
