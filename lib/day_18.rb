class Solution18
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @grid = nil
    process
  end

  attr_reader :data, :grid

  def run
    faces = 0
    @data.each do |p|
      faces += 6
      adj = p.neighbours
      adj.each do |p2|
        faces -= 1 if @grid.check(p2[0], p2[1], p2[2]) == true
      end
    end
    return faces
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines
      .map(&:chomp)
      .map { |el| el.split(",").map(&:to_i) }
      .map { |el| Point3D.new(el[0], el[1], el[2]) }
    file.close
    @grid = Grid3D.new(@data)
  end
end

class Point3D
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  attr_reader :x, :y, :z

  def neighbours
    return [
             [-1, 0, 0], [1, 0, 0], [0, -1, 0], [0, 1, 0], [0, 0, -1], [0, 0, 1],
           ].map { |p| [p[0] + @x, p[1] + @y, p[2] + @z] }
  end

  def ==(other)
    self.x == other.x && self.y == other.y && self.z == other.z
  end
end

class Grid3D
  def initialize(arr)
    @length = arr.map { |el| el.x }.max
    @width = arr.map { |el| el.y }.max
    @height = arr.map { |el| el.z }.max
    @grid = {}
    arr.each do |point|
      @grid[point.x] = {} if @grid[point.x] == nil
      @grid[point.x][point.y] = {} if @grid[point.x][point.y] == nil
      @grid[point.x][point.y][point.z] = true
    end
  end

  attr_reader :grid

  def check(x, y, z)
    return "no point with x = #{x}" if @grid[x] == nil
    return "no point with x = #{x}, y = #{y}" if @grid[x][y] == nil
    return "no point with x = #{x}, y = #{y}, z = #{z}" if @grid[x][y][z] == nil
    return true
  end
end
