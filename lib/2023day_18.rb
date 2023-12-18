require_relative "../utils/grid_from_points.rb"
Instruction = Struct.new(:dir, :dist, :colour)

class Solution18
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def splitIns
    out = []
    @data.each do |line|
      dir, dist, col = line.split(" ")
      col = col[1..-2]
      out << Instruction.new(dir, dist.to_i, col)
    end
    return out
  end

  def takeStep(loc, dir)
    return [loc[0] + dir[0], loc[1] + dir[1]]
  end

  def makePoints(r, c, instructions)
    dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    d = dirs["UDLR".index(instructions.dir)]
    cur = [r, c]
    out = []
    instructions.dist.times do
      cur = takeStep(cur, d)
      out << cur
    end
    return out
  end

  def makeAllPoints(q)
    points = Set.new()
    points << [0, 0]
    allIns = q === 1 ? splitIns : splitIns2
    r, c = [0, 0]
    allIns.each do |instr|
      newPoints = makePoints(r, c, instr)
      r, c = newPoints[-1]
      newPoints.each { |p| points << p }
    end
    return points
  end

  def getGrid(q)
    grid = GridFromPoints.new(makeAllPoints(q), ".", "#")
    # puts grid
    return grid
  end

  def convertCol(col)
    d = "RDLU"[col[-1].to_i]
    dist = col[1..-2].to_i(16)
    return "#{d} #{dist} #{col}"
  end

  def splitIns2
    out = []
    @data.each do |line|
      dir, dist, col = line.split(" ")
      col = col[1..-2]
      realIns = convertCol(col)
      dir, dist, col = realIns.split(" ")
      out << Instruction.new(dir, dist.to_i, col)
    end
    return out
  end

  def getCorners(q)
    out = [[0, 0]]
    dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    ins = q === 1 ? splitIns : splitIns2
    r, c = [0, 0]
    ins.each do |d|
      dir = dirs["UDLR".index(d.dir)].map { |v| v * d.dist }
      r, c = takeStep([r, c], dir)
      out << [r, c]
    end
    return out
  end

  def run(r, c)
    dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    grid = getGrid(1)
    size = grid.points.length
    stack = [[r, c]]
    while stack.length > 0
      r, c = stack.pop()
      if grid.read(r, c) === "."
        grid.set(r, c, "#")
        grid.points << [r, c]
        size += 1
      else
        next
      end
      dirs.each do |d|
        rr, cc = takeStep([r, c], d)
        next if grid.read(r, c) == nil
        stack << [rr, cc]
      end
    end
    return size
  end

  def shoelace(corners)
    area = 0.0
    # shoelace formula
    (corners.length - 1).times do |i|
      a = corners[i]
      b = corners[i + 1]
      y1, x1 = a
      y2, x2 = b
      area += x1 * y2 - x2 * y1
      
      # area += (y1 + y2) * (x1 - x2)
      # puts "working with corners: #{a} and #{b} => #{area}"
    end
    return area / 2
  end

  def run_2(q)
    dirs = q === 1 ? splitIns : splitIns2
    corners = getCorners(q)
    border = 0
    dirs.each do |d|
      border += d.dist
    end
    return shoelace(corners) + (border / 2) + 1
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
