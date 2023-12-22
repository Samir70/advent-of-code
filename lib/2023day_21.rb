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

  def getBigGrid
    grid = getGrid
    r, c = findStart(grid)
    wideData = @data.map do |line| 
      line.sub!("S", ".")
      line *= 5
    end
    # puts wideData * 5
    grid2 = GridFromStrings.new(wideData * 5)
    grid2.set(r + grid.rows*2, c + grid.cols*2, "S")
    return grid2
  end

  def findStart(grid)
    grid.rows.times do |r|
      grid.cols.times do |c|
        # puts "starting at: #{[r, c]}" if grid.read(r, c) == "S"
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

  def run(grid, steps)
    plots = [findStart(grid)]
    # puts "grid size: #{grid.rows}"
    steps.times do
      plots = takeStep(grid, plots)
    end
    return plots.length
  end

  def run_2(steps)
    # count filled gardens and partially filled gardens
    r = @data.length
    mid = (r - 1) / 2
    grid = getBigGrid
    return run(grid, steps) if steps <= mid + r + r
    a0 = run(grid, mid)
    a1 = run(grid, mid + r)
    a2 = run(grid, mid + r + r)

    puts "a0..2: #{[a0, a1, a2]}"
    # [3734, 33285, 92268]
    b0 = a0
    b1 = a1-a0
    b2 = a2-a1
    n = steps/ r
    return b0 + b1*n + (n*(n-1)/2)*(b2-b1)
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
