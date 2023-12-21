require_relative("../utils/grid_from_strings.rb")

class Solution21
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def findStart(grid)
    grid.rows.times do |r|
      grid.cols.times do |c|
        return [r, c] if grid.read(r, c) == "S"
      end
    end
    return nil
  end

  def addPoints(a, b)
    return [a[0] + b[0], a[1] + b[1]]
  end

  def takeStep(grid, points)
    dirs = [
      [-1, 0], [1, 0], [0, -1], [0, 1],
    ]
    out = Set.new
    points.each do |point|
      dirs.each do |d|
        r, c = addPoints(d, point)
        next if grid.read(r, c) == nil || grid.read(r, c) == "#"
        out << [r, c]
      end
    end
    return *out
  end

  def run(steps)
    grid = getGrid
    plots = [findStart(grid)]
    steps.times do
      plots = takeStep(grid, plots)
    end
    return plots.length
  end

  def run_2(steps)
    # count filled gardens and partially filled gardens
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
