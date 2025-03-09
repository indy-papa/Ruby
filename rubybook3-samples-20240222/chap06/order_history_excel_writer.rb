# frozen_string_literal: true

require 'rubyXL'
require 'rubyXL/convenience_methods/cell'
require 'rubyXL/convenience_methods/workbook'

require_relative './order_history_reader.rb'

class OrderHistoryExcelWriter # <1>
  def initialize(order_filename, excel_filename) # <2>
    @order_filename = order_filename
    @excel_filename = excel_filename
    @book = RubyXL::Workbook.new # <3>
    @sheet = @book[0] # <4>
  end

  def write_header # <5>
    @sheet.add_cell(0, 0, 'ID') # <6>
    @sheet.add_cell(0, 1, '注文番号')
    @sheet.add_cell(0, 2, '注文日')
    @sheet.add_cell(0, 3, '合計')
    @sheet.add_cell(0, 4, 'お届け先')
    @sheet.add_cell(0, 5, '明細')
  end

  def add_cell_with_date_format(row, column, order_date) # <1>
    cell = @sheet.add_cell(row, column, 0)
    od = Date.strptime(order_date, '%Y年 %m月 %d日') # <2>
    cell.change_contents(od)
    cell.set_number_format('yyyy年mm月dd日')
  end

  def add_cell_with_price_format(row, column, price) # <3>
    cell = @sheet.add_cell(row, column, 0)
    p = price.split(/\D+/).join.to_i # <4>
    cell.change_contents(p)
    cell.set_number_format('#,##0円') # <5>
  end

  def write_records # <1>
    row = 1 # <2>
    OrderHistoryReader.new(@order_filename) do |reader| # <3>
      reader.each do |rec| # <4>
        @sheet.add_cell(row, 0, rec['ID']) # <5>
        @sheet.add_cell(row, 1, rec['注文番号'])
        add_cell_with_date_format(row, 2, rec['注文日'])
        add_cell_with_price_format(row, 3, rec['合計'])
        @sheet.add_cell(row, 4, rec['お届け先'])
        @sheet.add_cell(row, 5, rec['明細'])
        row += 1 # <6>
      end
    end
  end

  def write_order_history # <7>
    write_header
    write_records
    @book.write(@excel_filename) # <8>
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Order History File:  #{ARGV[0]}"
  puts "Order History Excel: #{ARGV[1]}"
  app = OrderHistoryExcelWriter.new(ARGV[0], ARGV[1]) # <1>
  app.write_order_history # <2>
end

