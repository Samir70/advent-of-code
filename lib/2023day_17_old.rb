require_relative "../utils/grid_from_strings.rb"
require_relative "../utils/grid_from_points.rb"
require_relative "../utils/minHeap.rb"

class Solution17
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @dirs = [
      ["U", [-1, 0]],
      ["D", [1, 0]],
      ["L", [0, -1]],
      ["R", [0, 1]],
    ]
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def takeStep(loc, dir)
    return [loc[0] + dir[0], loc[1] + dir[1]]
  end

  def makeKey(ps)
    return [ps.row, ps.col]
  end

  # def validSteps(lastSteps)
  #   return ["D", "R"] if lastSteps === "NNN"
  #   d1, d2, d3 = lastSteps.split("")
  #   if d1 === d2 && d2 === d3
  #     return ["U", "D"] if d1 == "L" || d1 == "R"
  #     return ["L", "R"] if d1 == "U" || d1 == "D"
  #   else
  #     return [*validSteps([d3, d3, d3].join("")), d3]
  #   end
  # end

  def run
    offset = 10000000
    grid = getGrid
    costs = []
    grid.rows.times do |r|
      rowCosts = []
      grid.cols.times do |c|
        rowCosts << Float::INFINITY
      end
      costs << rowCosts
    end
    visited = Set.new()
    locs = MinHeap.new
    locs << MinHeapElement.new([[0, 0], "N", 0], 0) # [loc, dir, count], cost
    costs[0][0] = 0
    notDone = true
    while notDone
      cur = locs.pop
      # puts cur
      @dirs.each do |dir, vector|
        loc, d, dCount = cur.val
        cost = cur.priority
        next if d == "U" and dir == "D"
        next if d == "D" and dir == "U"
        next if d == "L" and dir == "R"
        next if d == "R" and dir == "L"
        next if d == dir && dCount == 3
        r, c = takeStep(loc, vector)
        next if r < 0 || c < 0
        next if r >= grid.rows || c >= grid.cols
        # puts "at #{loc} wanting to go #{dir}=#{vector}"
        dCount = d == dir ? dCount + 1 : 1
        newCost = cost + grid.read(r, c).to_i
        if r == grid.rows - 1 && c == grid.cols - 1
          notDone = false
        end
        compareCost = dCount * offset + newCost
        next if compareCost > costs[r][c]
        costs[r][c] = compareCost
        locs << MinHeapElement.new([[r, c], dir, dCount], newCost)
      end
    end
    return costs[grid.rows - 1][grid.cols - 1] % offset
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
