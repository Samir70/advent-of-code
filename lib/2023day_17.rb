require_relative "../utils/grid_from_strings.rb"
require_relative "../utils/grid_from_points.rb"
require_relative "../utils/minHeap.rb"

class Solution17
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def takeStep(loc, dir)
    return [loc[0] + dir[0], loc[1] + dir[1]]
  end

  def inRange?(pos, maxR, maxC)
    r, c = pos
    # puts "#{[r, c, maxR, maxC]} in range? #{(0...maxR).include?(r)} && #{(0...maxC).include?(c)}"
    return (0...maxR).include?(r) && (0...maxC).include?(c)
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

  def run(minDist, maxDist)
    grid = getGrid
    dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]
    visited = Set.new()
    costs = {}
    locs = MinHeap.new
    locs << MinHeapElement.new([0, 0, -1], 0) # [r, c, disallowedDir], cost
    while locs.size > 0
      cur = locs.pop
      # puts cur
      r, c, disallowedDir = cur.val
      cost = cur.priority
      return cost if r === grid.rows - 1 && c === grid.cols - 1
      next if visited.include?([r, c, disallowedDir])
      visited << [r, c, disallowedDir]
      4.times do |dir|
        costIncrease = 0
        next if dir === disallowedDir || (dir + 2) % 4 == disallowedDir
        (1..maxDist).each do |dist|
          rr, cc = takeStep([r, c], dirs[dir].map { |el| el * dist })
          if inRange?([rr, cc], grid.rows, grid.cols)
            # puts "next loc: #{[rr, cc]}"
            costIncrease += grid.read(rr, cc).to_i
            next if dist < minDist
            newCost = cost + costIncrease
            recordedCost = costs[[rr, cc, dir]] || Float::INFINITY
            next if recordedCost <= newCost
            costs[[rr, cc, dir]] = newCost
            locs << MinHeapElement.new([rr, cc, dir], newCost)
          end
        end
      end
    end
    return "oops"
  end

  def run_2
    return  run(4, 10)
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
