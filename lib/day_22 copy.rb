require_relative "../utils/grid_from_strings"

class Solution22
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @instructions = []
    @points = []
    @faces = []
    process
    @grid = HashGrid.new(@points)
    @loc = [1, @data.first.index(".") + 1]
  end

  attr_reader :instructions, :points, :grid, :loc, :faces

  def run
    d = Direction.new()
    puts "starting from #{@loc}"
    @instructions.each do |step|
      if step == "L" || step == "R"
        d.change(step)
      else
        step.times do
          case d.dir
          when 0
            @loc = @grid.step_right(@loc[0], @loc[1])
          when 1
            @loc = @grid.step_down(@loc[0], @loc[1])
          when 2
            @loc = @grid.step_left(@loc[0], @loc[1])
          when 3
            @loc = @grid.step_up(@loc[0], @loc[1])
          end
        end
      end
      puts "Followed step #{step}\nNow at #{@loc}, facing dir #{d.dir}"
    end
    r, c = @loc
    puts "finished at #{[r, c]} with direction #{d.dir}"
    return 1000 * r + 4 * c + d.dir
  end

  def run_2
  end

  def make_full_net
    back, bottom, left, top, front, right = @faces.map {|f| GridFromStrings.new(f)}
    out = []
    aa = front.rotate.rotate
    ab = left.rotate.rotate.rotate
    ac = back
    ad = right.rotate.rotate
    top_row = GridFromStrings.add(aa, ab, ac, ad)
    mid_row = GridFromStrings.add(bottom, left, top, right.rotate)
    bottom_row = GridFromStrings.add(back.rotate.rotate, left.rotate, top, right.rotate)
    puts top_row.join("")
    puts mid_row.join("")
    puts bottom_row.join("")
    return top_row.concat(mid_row).concat(bottom_row)
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    r = 1
    @data[0..-2].each do |line|
      for c in 0...(line.length)
        @points << [r, c + 1, line[c]] if line[c] != " "
      end
      r += 1
    end
    @instructions = split_instructions(@data.last)
    cube_size = (@data.length - 2)/3
    @faces << @data[0...cube_size].map {|s| s[(cube_size * 2)..(cube_size*3)]}
    @faces << @data[(cube_size)...(cube_size * 2)].map {|s| s[(0)...(cube_size)]}
    @faces << @data[(cube_size)...(cube_size * 2)].map {|s| s[(cube_size)...(cube_size*2)]}
    @faces << @data[(cube_size)...(cube_size * 2)].map {|s| s[(cube_size*2)...(cube_size*3)]}
    @faces << @data[(cube_size*2)...(cube_size * 3)].map {|s| s[(cube_size*2)...(cube_size*3)]}
    @faces << @data[(cube_size*2)...(cube_size * 3)].map {|s| s[(cube_size*3)...(cube_size*4)]}
  end
end

# from day 19
def add_vector(a, b)
  len = a.length
  puts "#{a} and #{b} can't be added" if b.length != len
  out = []
  len.times do |i|
    out << a[i] + b[i]
  end
  return out
end

def convert(str)
  if str == "R" || str == "L"
    return str
  end
  return str.to_i
end

def split_instructions(str)
  return str.scan(/[0123456789]+|[RL]+/).map { |el| convert(el) }
end

class Direction
  def initialize
    @dir = 0
    @dirs = [
      [0, 1], [1, 0], [0, -1], [-1, 0],
    ]
  end

  attr_reader :dir

  def vector
    return @dirs[dir]
  end

  def change(c)
    @dir = (@dir + 1) % 4 if c == "R"
    @dir = (@dir - 1) % 4 if c == "L"
  end
end

class HashGrid
  def initialize(arr)
    @points = {}
    @max_row = 0
    arr.each do |p|
      r, c, block = p
      @points[r] = { :min => 100000, :max => -1 } if @points[r] == nil
      @points[r][c] = block
      @points[r][:min] = c if c < @points[r][:min]
      @points[r][:max] = c if c > @points[r][:max]
      @max_row = r if r > @max_row
    end
  end

  def read(r, c)
    return nil if @points[r] == nil
    return @points[r][c]
  end

  def step_right(r, c)
    return [r, c + 1] if read(r, c + 1) == "."
    return [r, c] if read(r, c + 1) == "#"
    wrap = @points[r][:min]
    return [r, wrap] if read(r, wrap) == "."
    return [r, c] if read(r, wrap) == "#"
    return nil
  end
  def step_left(r, c)
    return [r, c - 1] if read(r, c - 1) == "."
    return [r, c] if read(r, c - 1) == "#"
    wrap = @points[r][:max]
    return [r, wrap] if read(r, wrap) == "."
    return [r, c] if read(r, wrap) == "#"
    return nil
  end

  def step_down(r, c)
    return [r + 1, c] if read(r + 1, c) == "."
    return [r, c] if read(r + 1, c) == "#"
    wrap = 1
    wrap += 1 while read(wrap, c) == nil
    return read(wrap, c) == "#" ? [r, c] : [wrap, c]
  end
  def step_up(r, c)
    return [r - 1, c] if read(r - 1, c) == "."
    return [r, c] if read(r - 1, c) == "#"
    wrap = @max_row
    wrap -= 1 while read(wrap, c) == nil
    return read(wrap, c) == "#" ? [r, c] : [wrap, c]
  end

  def to_s
    @points.keys.each do |r|
      line = ""
      for c in 1..@points[r][:max]
        if read(r, c) == nil
          line += " "
        else
          line += read(r, c)
        end
      end
      puts line #+ "          row: #{r}, max_c: #{@points[r][:max]}"
    end
  end
end
