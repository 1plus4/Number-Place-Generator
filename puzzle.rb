# -*- coding: utf-8 -*-

class Puzzle
  def initialize
    generate_answer
  end

  BoxOfIndex = [
                0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,
                3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,
                6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8
               ].freeze

  def has_duplicates?
    0.upto(8) {|row| return true if row_digits(row).uniq! }
    0.upto(8) {|col| return true if col_digits(col).uniq! }
    0.upto(8) {|box| return true if box_digits(box).uniq! }
    false
  end

  AllDigits = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def possible(row, col, box)
    AllDigits - (row_digits(row) + col_digits(col) + box_digits(box))
  end

  def row_digits(row)
    @grid[row*9, 9] - [0]
  end

  def col_digits(col)
    result = []
    col.step(80, 9) do |i|
      v = @grid[i]
      result << v if (v != 0)
    end
    result
  end

  BoxToIndex = [0, 3, 6, 27, 30, 33, 54, 57, 60].freeze

  def box_digits(box)
    i = BoxToIndex[box]
    [
     @grid[i],    @grid[i+1],  @grid[i+2],
     @grid[i+9],  @grid[i+10], @grid[i+11],
     @grid[i+18], @grid[i+19], @grid[i+20],
    ] - [0]
  end

  def fill_row(row)
    impossible_numbers = Array.new(9).map!{ Array.new }
    col = 0
    while true
      digit = possible(row/9, col, BoxOfIndex[row+col]).sample
      if !digit || impossible_numbers[col].include?(digit)
        return false if col == 0
        impossible_numbers[col] = Array.new
        col -= 1
        impossible_numbers[col].push(@grid[row+col])
      else
        @grid[row+col] = digit
        col += 1
        return true if col == 9
      end
    end
  end

  def generate_answer
    @grid = Array.new(81, 0)
    row = 0
    while true
      if fill_row(row*9)
        row += 1
        return true if row == 9
      else
        @grid[row*9, 9] = Array.new(9, 0)
        row -= 1
        @grid[row*9, 9] = Array.new(9, 0)
      end
    end
  end

  def print_grid
    9.times do |col|
      9.times do |row|
        print @grid[col*9+row].to_s + ' '
      end
      puts
    end
  end
end

puzzle = Puzzle.new
puzzle.print_grid

