require_relative "../utils/grid_from_points"

def toward_zero(n)
  return n == 0 ? 0 : n > 0 ? n - 1 : n + 1
end
def away_from_zero(n)
  return  n >= 0 ? n + 1 : n - 1
end

class Solution09
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
    @head = [0, 0]
    @tail = [0, 0]
    @tail_visited = Set["0, 0"]
    @knots = []
    10.times do
      @knots << [0, 0]
    end
  end

  def run
    @data.each do |cmd|
      move(cmd)
    end
    return @tail_visited.size
  end

  def run_2
    @data.each do |cmd|
      move_2(cmd)
    end
    return @tail_visited.size
  end

  def move(str)
    dir, dist = str.split(" ")
    dr, dc = { "R" => [0, 1], "L" => [0, -1], "U" => [1, 0], "D" => [-1, 0] }[dir]
    dist.to_i.times do
      @head = add_vector(@head, [dr, dc])
      @tail = update_tail(@head, @tail)
      @tail_visited.add(make_key(@tail))
      # puts "#{@head}, #{@tail}"
    end
  end

  def move_2(str)
    dir, dist = str.split(" ")
    dr, dc = { "R" => [0, 1], "L" => [0, -1], "U" => [1, 0], "D" => [-1, 0] }[dir]
    dist.to_i.times do
      @knots[0] = add_vector(@knots[0], [dr, dc])
      9.times do |i|
        # puts "Updating knots #{i} and #{i + 1}: #{@knots[i]}, #{@knots[i+1]}"
        @knots[i + 1] = update_tail(@knots[i], @knots[i + 1])
      end
      @tail_visited.add(make_key(@knots[9]))
      # grid = GridFromPoints.new(Array(@tail_visited).map {|el| el.split(", ").map(&:to_i)}, ".", "#")
      # puts "during command #{str}: #{@knots}"
      # grid = GridFromPoints.new(@knots + [[20, 20]], ".", "index")
      # puts grid
    end
  end

  def update_tail(head, tail)
    hr, hc = head
    tr, tc = tail
    dr, dc = diff_vector(head, tail)
    modified_diff = [
      (dc.abs == 2 && dr.abs != 2) ? away_from_zero(dr) : dr,
      (dr.abs == 2 && dc.abs != 2) ? away_from_zero(dc) : dc
    ]
    tail_adjustment = [toward_zero(modified_diff[0]), toward_zero(modified_diff[1])]
    return add_vector(tail, tail_adjustment)
  end

  def add_vector(a, b)
    # puts "adding #{a} and #{b}"
    return [a[0] + b[0], a[1] + b[1]]
  end

  def diff_vector(a, b)
    # puts "diffing #{a} and #{b}"
    return [a[0] - b[0], a[1] - b[1]]
  end

  def diff_to_req_transform(diff)
    key_diff = "#{diff[0]}, #{diff[1]}"
    hash = {
      # head-tail => what tail should do
      "-2, -1" => [-1, -1], "-2, 0" => [-1, 0], "-2, 1" => [-1, 1],

    }
  end

  def make_key(arr)
    return arr.join(", ")
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end

  def tail_visited
    return @tail_visited.size
  end

  attr_reader :head, :tail
end
