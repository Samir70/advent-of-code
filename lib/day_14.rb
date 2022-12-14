require_relative "../utils/grid_from_points"

class Solution14
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @grid = []
    @entry = [0, 500]
    process
  end

  attr_reader :grid, :entry

  def run
    make_grid
    result = drop_sand
    count = 0
    while result != nil
      count += 1
      result = drop_sand
    end
    return count
  end

  def run_2
    make_grid2
    @grid.add_row(".")
    @grid.add_row("#")
    result = drop_sand
    count = 0
    while result != "full" && count < 100000
      count += 1
      result = drop_sand
    end
    return count + 1
  end

  def extract_points(str)
    points = []
    xy = str.split("->")
    xy.each do |p|
      c, r = p.split(",").map(&:to_i)
      points << [r, c]
    end
    return points
  end

  def make_lines(str)
    points = Set.new()
    corners = extract_points(str)
    prev = corners[0]
    points << prev
    corner_idx = 1
    while corner_idx < corners.length
      cur = corners[corner_idx]
      r, c = prev
      i, j = cur
      prev = [i, j]
      if r == i
        j, c = [c, j] if j < c
        for x in c..j
          points.add([r, x])
        end
      elsif c == j
        i, r = [r, i] if i < r
        for y in r..i
          points.add([y, c])
        end
      else
        return "neither row nor column match #{[r, c]} -> #{[i, j]}"
      end
      corner_idx += 1
    end
    return points
  end

  def make_grid
    points = [[0, 500]]
    @data.each do |line|
      new_points = make_lines(line)
      if new_points.class == Set
        points.concat(Array(new_points))
      else
        puts new_points
      end
    end
    @grid = GridFromPoints.new(points, ".", "#")
    @entry = [0, 500 - @grid.min_col]
    @grid.change_point(@entry[0], @entry[1], "+")
  end
  def make_grid2
    points = [[0, 335], [0, 665], [0, 500]]
    @data.each do |line|
      new_points = make_lines(line)
      if new_points.class == Set
        points.concat(Array(new_points))
      else
        puts new_points
      end
    end
    @grid = GridFromPoints.new(points, ".", "#")
    @entry = [0, 500 - @grid.min_col]
    @grid.change_point(@entry[0], @entry[1], "+")
  end

  def drop_sand
    r, c = @entry
    b_left, b, b_right = look_below(r, c)
    return "full" if [b_left, b, b_right] == ["o", "o", "o"]
    while !settled?(b_left, b, b_right)
      # puts "below #{[r, c]}: #{b_left}, #{b}, #{b_right}    settled: #{settled?(b_left, b, b_right)}"
      if b == "."
        r += 1
      elsif b_left == "."
        r += 1
        c -= 1
      else
        r += 1
        c += 1
      end
      b_left, b, b_right = look_below(r, c)
    end
    if [b_left, b, b_right].include?(nil)
      return nil
    end
    @grid.change_point(r, c, "o")
    # puts grid
    return [r, c]
  end

  def settled?(b_left, b, b_right)
    if b == "." || b_left == "." || b_right == "."
      return false
    end
    return true
  end

  def look_below(r, c)
    b_left = r + 1 < @grid.height ? @grid.grid[r + 1][c - 1] : nil
    b_right = r + 1 < @grid.height ? @grid.grid[r + 1][c + 1] : nil
    b = r + 1 < @grid.height ? @grid.grid[r + 1][c] : nil
    return [b_left, b, b_right]
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
