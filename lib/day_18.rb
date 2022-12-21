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
    interior_points = Set.new()
    for x in 0..20
      for y in 0..20
        for z in 0..20
          interior_points << [x, y, z] if @grid.is_interior?(x, y, z) == true
        end
      end
    end
    # some of the points we currently list may have neighbours which are not interior
    # ie: they are in a pocket that has a hole to the outside.
    # spot one of these pockets by finding a point with a neighbour that is not in the list
    # remove all points that can be reached non-diagonally from this point
    to_remove = []
    interior_points.each do |point|
      x, y, z = point
      p = Point3D.new(x, y, z)
      adj = p.neighbours
      to_remove << point if adj.any? { |el| !interior_points.include?(el) && @grid.check(el[0], el[1], el[2]) != true }
    end
    # puts "to remove: #{to_remove}"
    while to_remove.length > 0
      x, y, z = to_remove.pop
      p = Point3D.new(x, y, z)
      adj = p.neighbours
      interior_points.delete([x, y, z])
      adj.each do |el|
        to_remove << el if interior_points.include?(el)
      end
    end
    return interior_points.to_a
  end

  def process
    if @file_name.class == String
      file = File.new(@file_name)
      @data = file.readlines
        .map(&:chomp)
        .map { |el| el.split(",").map(&:to_i) }
        .map { |el| Point3D.new(el[0], el[1], el[2]) }
      file.close
    else
      @data = @file_name.map { |el| Point3D.new(el[0], el[1], el[2]) }
    end
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
    # puts "made a grid of length #{@length}, width #{@width}, height #{@height}"
  end

  attr_reader :grid

  def check(x, y, z)
    return "no point with x = #{x}" if @grid[x] == nil
    return "no point with x = #{x}, y = #{y}" if @grid[x][y] == nil
    return "no point with x = #{x}, y = #{y}, z = #{z}" if @grid[x][y][z] == nil
    return true
  end

  def is_interior?(x, y, z)
    return "is part of shape" if check(x, y, z) == true
    # puts "checking to left"
    to_left = false
    for i in 0...x
      to_left = true if check(i, y, z) == true
    end
    return false if !to_left

    # puts "checking to right"
    to_right = false
    for i in (x + 1)..@length
      to_right = true if check(i, y, z) == true
    end
    return false if !to_right

    # puts "checking to front"
    to_front = false
    for i in 0...y
      to_front = true if check(x, i, z) == true
    end
    return false if !to_front

    # puts "checking to back"
    to_back = false
    for i in (y + 1)..@width
      to_back = true if check(x, i, z) == true
    end
    return false if !to_back

    # puts "checking to down"
    to_down = false
    for i in 0...z
      to_down = true if check(x, y, i) == true
    end
    return false if !to_down

    # puts "checking to up"
    to_up = false
    for i in (z + 1)..@height
      to_up = true if check(x, y, i) == true
    end
    return false if !to_up

    return true
  end
end
