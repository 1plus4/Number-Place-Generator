# -*- coding: utf-8 -*-

TABLE_SIZE = 9

class TableGenerator
  def initialize
    @table = initialize_table
    p @table
  end

  def initialize_table
    table = Array.new(TABLE_SIZE, Array.new(TABLE_SIZE, ' '))
  end

  def generate_one_to_nine_array
    @one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end

TableGenerator.new
