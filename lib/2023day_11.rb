require_relative "../utils/grid_from_strings"

class Solution11
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def countGals(str)
    return str.count("#")
  end

  def emptyCols(grid)
    out = []
    grid.cols.times do |c|
      out << c if countGals(grid.getCol(c)) === 0
    end
    return out.reverse
  end

  def emptyRows(grid)
    out = []
    grid.rows.times do |r|
      out << r if countGals(grid.getRow(r)) === 0
    end
    return out.reverse
  end

  # def getExpanded
  #   grid = getGrid
  #   empties = emptyCols(grid)
  #   empties.each do |c|
  #     grid.addCol(c)
  #   end
  #   empties = emptyRows(grid)
  #   empties.each do |r|
  #     grid.addRow(r)
  #   end
  #   # puts grid
  #   return grid
  # end

  def findGals
    out = []
    grid = getGrid
    grid.rows.times do |r|
      grid.cols.times do |c|
        out << [r, c] if grid.read(r, c) === "#"
      end
    end
    # puts "#{out}"
    return out
  end

  def dist(a, b, eRows, eCols, expansion)
    v = (a[0] - b[0]).abs
    h = (a[1] - b[1]).abs
    # puts "#{[a, b, v, h, v + h]}"
    eRows.each do |er|
      v += expansion if er.between?(a[0], b[0]) || er.between?(b[0], a[0])
      # puts "#{[a, b, er, v]}"
    end
    eCols.each do |ec|
      h += expansion if ec.between?(a[1], b[1]) || ec.between?(b[1], a[1])
      # puts "#{[a, b, ec, h]}"
    end
    return v + h
  end

  def run(expansion)
    grid = getGrid
    gals = findGals
    eCols = emptyCols(grid)
    eRows = emptyRows(grid)
    n = gals.length
    sum = 0
    n.times do |g1|
      ((g1 + 1)...n).each do |g2|
        d = dist(gals[g1], gals[g2], eRows, eCols, expansion - 1)
        # puts "dist #{g1} and #{g2} is #{d}"
        sum += d
      end
    end
    return sum
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
