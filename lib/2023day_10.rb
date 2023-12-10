require_relative "../utils/grid_from_strings"

class Solution10
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
        return [r, c] if grid.read(r, c) === "S"
      end
    end
    return nil
  end

  def reverseDir(dr, dc)
    return [-1 * dr, -1 * dc]
  end

  def leftOf(dir)
    return [0, -1] if dir === [-1, 0]
    return [0, 1] if dir === [1, 0]
    return [-1, 0] if dir === [0, 1]
    return [1, 0] if dir === [0, -1]
    return nil
  end

  def takeStep(loc, dir)
    return [loc[0] + dir[0], loc[1] + dir[1]]
  end

  def isLegal(dir, options)
    rd = reverseDir(*dir)
    return options[0] === rd || options[1] === rd
  end

  def traverse(grid, cur, dir, replace)
    up = [-1, 0]
    down = [1, 0]
    left = [0, -1]
    right = [0, 1]
    dirs = {
      "." => [],
      # "S" => [up, down, left, right], allows too much freedom of movement
      "|" => [up, down], #7101
      "-" => [left, right], #7101
      "L" => [up, right], #7102
      "J" => [up, left], #14201 but not a loop
      "7" => [down, left], #7100
      "F" => [down, right], #14201 but not a loop
    }
    count = 1
    r, c = takeStep(cur, dir)
    gridLocs = [cur]
    leftOfs = []
    return nil if r < 0 || c < 0
    while grid.read(r, c) != "S"
      return nil if grid.read(r, c) === "."
      options = dirs[grid.read(r, c)]
      stepHereWaslegal = isLegal(dir, options)
      return nil if !stepHereWaslegal
      gridLocs << [r, c]
      toLeft = leftOf(dir)
      # puts "#{[r, c]} = #{grid.read(r, c)} options: #{options}, dir: #{dir}"
      # puts "toLeft: #{toLeft}"
      # puts "pushing #{[r, c]} to gridLocs"
      a, b = takeStep([r, c], toLeft)
      if a >= 0 && b >= 0 && grid.read(a, b) != nil && !leftOfs.include?([a, b])
        leftOfs << [a, b]
      end
      grid.set(r, c, replace) if replace != nil
      dir = options[0] === reverseDir(*dir) ? options[1] : options[0]
      r, c = takeStep([r, c], dir)
      count += 1
    end
    grid.set(r, c, replace) if replace != nil
    return {
             count: count,
             gridLocs: gridLocs,
             leftOfs: leftOfs.filter { |loc| !gridLocs.include?(loc) },
           }
  end

  def run
    grid = GridFromStrings.new(@data)
    startLoc = findStart(grid)
    # puts grid, startLoc
    distances = []
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dir|
      d = traverse(grid, startLoc, dir, nil)
      d = d[:count] if d != nil
      puts "starting: #{dir} dist:#{d}"
      distances.push(d) if d != nil
    end
    # puts "#{distances}"
    return distances[0] / 2
  end

  def countPipes(grid, r, c)
    out = []
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dir|
      count = 0
      a, b = r, c
      # puts "counting from #{[a, b]} = #{grid.read(a, b)}"
      while a >= 0 && b >= 0 && grid.read(a, b) != nil
        count += 1 if grid.read(a, b) === "#"
        # puts "At #{[a, b]} = #{grid.read(a, b)} (count = #{count})"
        a, b = takeStep([a, b], dir)
      end
      out.push(count)
    end
    return out
  end

  def getMap(dir)
    grid = GridFromStrings.new(@data)
    startLoc = findStart(grid)
    res = traverse(grid, startLoc, dir, "#")
    gridLocs = res[:gridLocs]
    leftOfs = res[:leftOfs]
    # puts "total: #{grid.rows * grid.cols} #{gridLocs.length}, #{leftOfs.length}"
    # puts "#{leftOfs}"
    grid.keepOnly("#")
    grid.rows.times do |r|
      grid.cols.times do |c|
        grid.set(r, c, @data[r][c]) if grid.read(r, c) === "#"
      end
    end
    leftOfs.each do |loc|
      grid.set(*loc, "*")
    end
    return { grid: grid, gridLocs: gridLocs, leftOfs: leftOfs }
  end

  def countVerts(str, i)
    return [str[0, i].count("|LF7J"), str[i + 1, str.length].count("|LF&J")]
  end

  def countHors(str, i)
    return [str[0, i].count("-LF7J"), str[i + 1, str.length].count("-LF&J")]
  end

  def isBounded?(grid, r, c)
    counts = countVerts(grid.getRow(r), c)
    # puts "at:#{[r, c]} Verts: #{counts} str: #{grid.getRow(r)}"
    return false if counts[0] % 2 === 0 or counts[1] % 2 === 0
    counts = countHors(grid.getCol(c), r)
    # puts "at:#{[r, c]} Hors: #{counts} str: #{grid.getCol(c)}"
    return false if counts[0] % 2 === 0 or counts[1] % 2 === 0
    return true
  end

  def run_2(dir)
    res = getMap(dir)
    grid = res[:grid]
    gridLocs = res[:gridLocs]
    leftOfs = res[:leftOfs]
    # puts grid
    count = 0
    leftOfs.each do |loc|
      stack = [loc]
      while stack.length > 0
        newStack = []
        while stack.length > 0
          cur = stack.pop()
          [[0, 0], [-1, 0], [1, 0], [0, -1], [0, 1]].each do |dir|
            a, b = takeStep(cur, dir)
            if a >= 0 && b >= 0 && grid.read(a, b) != nil && !gridLocs.include?([a, b])
              newStack << [a, b]
              grid.set(a, b, nil)
              # puts "counted #{[a, b]}"
              count += 1
            end
          end
        end
        stack = [*newStack]
      end
    end
    return count
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
