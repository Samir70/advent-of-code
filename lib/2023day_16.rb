require_relative "../utils/grid_from_strings.rb"
require_relative "../utils/grid_from_points.rb"
LightBeam = Struct.new(:row, :col, :dir)

class Solution16
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def takeStep(beam)
    r = beam.row + beam.dir[0]
    c = beam.col + beam.dir[1]
    return [r, c]
  end

  def redirect(dir, tile)
    if tile == "."
      return [dir]
    elsif tile == "-"
      if dir == [0, 1] or dir == [0, -1]
        return [dir]
      else
        return [[0, -1], [0, 1]]
      end
    elsif tile == "|"
      if dir == [-1, 0] or dir == [1, 0]
        return [dir]
      else
        return [[-1, 0], [1, 0]]
      end
    elsif tile == "/"
      r, c = dir
      return [[-c, -r]]
    elsif tile == "\\"
      r, c = dir
      return [[c, r]]
    end
    return nil
  end

  def countEnergised(grid, beam)
    visited = Set.new()
    stack = [beam]
    while stack.length > 0
      cur = stack.pop()
      next if visited.include?(cur)
      visited << cur
      r, c = takeStep(cur)
      next if grid.read(r, c) == nil || r < 0 || c < 0
      newDirs = redirect(cur.dir, grid.read(r, c))
      newDirs.each do |newDir|
        newBeam = LightBeam.new(r, c, newDir)
        stack << newBeam
      end
    end
    gridCount = Set.new()
    visited.each do |beam|
      gridCount << [beam.row, beam.col]
    end
    energyGrid = GridFromPoints.new(gridCount, ".", "#")
    # puts energyGrid
    return gridCount.length
  end

  def run(beam)
    grid = getGrid
    return countEnergised(grid, beam)
  end

  def run_2
    grid = getGrid
    maxEnergised = 0
    grid.cols.times do |c|
      dirs = redirect([1, 0], grid.read(0, c))
      dirs.each do |d|
        energy = countEnergised(grid, LightBeam.new(0, c, d))
        # puts "0,#{c} => #{energy}"
        maxEnergised = energy if energy > maxEnergised
      end
    end
    r = grid.rows - 1
    grid.cols.times do |c|
      dirs = redirect([-1, 0], grid.read(r, c))
      dirs.each do |d|
        energy = countEnergised(grid, LightBeam.new(0, c, d))
        # puts "#{r},#{c} => #{energy}"
        maxEnergised = energy if energy > maxEnergised
      end
    end
    grid.rows.times do |r|
      dirs = redirect([0, 1], grid.read(r, 0))
      dirs.each do |d|
        energy = countEnergised(grid, LightBeam.new(r, 0, d))
        # puts "#{r},#{0} => #{energy}"
        maxEnergised = energy if energy > maxEnergised
      end
    end
    c = grid.cols - 1
    grid.rows.times do |r|
      dirs = redirect([0, -1], grid.read(r, c))
      dirs.each do |d|
        energy = countEnergised(grid, LightBeam.new(r, c, d))
        # puts "#{r},#{c} => #{energy}"
        maxEnergised = energy if energy > maxEnergised
      end
    end
    return maxEnergised
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
