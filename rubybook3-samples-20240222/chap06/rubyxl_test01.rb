# frozen_string_literal: true

require 'rubyXL' # <1>
require 'rubyXL/convenience_methods/cell' # <2>
require 'rubyXL/convenience_methods/workbook' # <3>

book = RubyXL::Workbook.new # <4>
sheet = book[0] # <5>

sheet.add_cell(0, 0, 'ISBN') # <6>
sheet.add_cell(0, 1, '書籍名')
sheet.add_cell(0, 2, '著者名')
sheet.add_cell(0, 3, '発売日')
sheet.add_cell(0, 4, '出版社')
sheet.add_cell(0, 5, '価格')

sheet.add_cell(1, 0, '978-4802611589') # <7>
sheet.add_cell(1, 1, '作って身につくC言語入門')
sheet.add_cell(1, 2, '久保秋 真')

pub_date = Date.strptime('2018/5/21', '%Y/%m/%d') # <8>
cell = sheet.add_cell(1, 3, 0) # <9>
cell.change_contents(pub_date) # <10>
cell.set_number_format('yyyy年mm月dd日') # <11>

sheet.add_cell(1, 4, 'ソシム')

price = '￥2,508' # <12>
cell = sheet.add_cell(1, 5, 0)
p = price.split(/\D+/).join.to_i # <13>
cell.change_contents(p) # <14>
cell.set_number_format('#,##0円') # <15>

sheet.add_cell(2, 0, '978-4634151048') # <16>
sheet.add_cell(2, 1, '和菓子を愛した人たち')
sheet.add_cell(2, 2, '虎屋文庫 編著')
pub_date = Date.strptime('2017/6/5', '%Y/%m/%d')
cell = sheet.add_cell(2, 3, 0)
cell.change_contents(pub_date)
cell.set_number_format('yyyy年mm月dd日')

sheet.add_cell(2, 4, '山川出版社')

price = '￥1,980'
cell = sheet.add_cell(2, 5, 0)
p = price.split(/\D+/).join.to_i
cell.change_contents(p)
cell.set_number_format('#,##0円')

book.write('bookinfo.xlsx') # <17>

