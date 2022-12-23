class Solution23
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @grid = nil
    process
  end

  attr_reader :grid

  def run
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    @grid = FlexiGrid.new()
    @data.each_with_index { |line, i| @grid.add(line, i + 1) }
    # puts @grid
  end
end

# changed from day 22
class Direction
  def initialize
    @dir = 0
  end

  attr_reader :dir

  def vector(dir)
    return @dirs[dir]
  end
end

Dirs = {
  "n" => [-1, 0],
  "s" => [1, 0],
  "e" => [0, 1],
  "w" => [0, -1],
}

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

def make_journey(loc, route)
  vectors = route.split("").map { |d| Dirs[d] }
  out = [].concat(loc)
  vectors.each { |v| out = add_vector(out, v) }
  return out
end

def nswe(r, c)
  north = ["nw", "n", "ne"].map { |journey| make_journey([r, c], journey) }
  south = ["sw", "s", "se"].map { |journey| make_journey([r, c], journey) }
  west = ["sw", "w", "nw"].map { |journey| make_journey([r, c], journey) }
  east = ["se", "e", "ne"].map { |journey| make_journey([r, c], journey) }
  return [north, south, west, east]
end

class FlexiGrid
  def initialize
    @elves = Set.new()
    @min_row = 1000000
    @min_col = 1000000
    @max_row = -100000
    @max_col = -100000
  end

  attr_reader :elves, :min_row, :min_col, :max_row, :max_col

  def add(str, row)
    @min_row = row if row < @min_row
    @max_row = row if row > @max_row
    for c in 1..str.length
      if str[c - 1] == "#"
        @elves.add([row, c])
        @min_col = c if c < @min_col
        @max_col = c if c > @max_col
      end
    end
  end

  def elf_at(loc)
    return @elves.include?(loc)
  end

  def to_s
    for r in @min_row..@max_row do
      row = ""
      for c in @min_col..@max_col do
        row += elf_at([r, c]) ? "#" : "."
      end
      puts row
    end
  end
end
