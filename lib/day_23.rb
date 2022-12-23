class Solution23
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @grid = nil
    process
  end

  attr_reader :grid

  def run(reps)
    d = 3
    reps.times do |rep_count|
      d = (d + 1) % 4
      proposals = {}
      @grid.elves.each do |elf|
        opts = options(elf)
        next if opts.all? 
        # puts "#{opts}" if elf == [0, 5]
        d_rot = 0
        while opts[(d + d_rot) % 4] == false && d_rot < 4
          d_rot += 1
        end
        chosen_d = opts[(d + d_rot) % 4] ? "nswe"[(d + d_rot) % 4] : ""
        if chosen_d != ""
          new_loc = add_vector(elf, Dirs[chosen_d])
          if proposals[new_loc] == nil
            proposals[new_loc] = elf
          else
            proposals[new_loc] = "too popular"
          end
        else
          new_loc = nil
        end
        # puts "elf #{elf} wants to go #{chosen_d} to #{new_loc}"
      end
      if proposals.length == 0
        return rep_count + 1
      end
      # puts "#{proposals}"
      # puts "#{rep_count + 1}" if rep_count % 20 == 0
      proposals.each do |prop|
        # puts "#{prop}"
        new_loc, old_loc = prop
        next if old_loc == "too popular"
        @grid.move_elf(old_loc, new_loc)
      end
      # puts @grid
    end
    return @grid.empties
  end

  def run_2
  end

  def options(elf)
    return nswe(elf).map do |d|
             d.map { |loc| grid.elf_at(loc) }
           end.map { |d| d.all? { |bool| bool == false } }
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

def nswe(loc)
  north = ["nw", "n", "ne"].map { |journey| make_journey(loc, journey) }
  south = ["sw", "s", "se"].map { |journey| make_journey(loc, journey) }
  west = ["sw", "w", "nw"].map { |journey| make_journey(loc, journey) }
  east = ["se", "e", "ne"].map { |journey| make_journey(loc, journey) }
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

  def move_elf(old_loc, new_loc)
    r, c = new_loc
    @elves.delete(old_loc)
    @elves.add(new_loc)
    @min_row = r if r < @min_row
    @max_row = r if r > @max_row
    @min_col = c if c < @min_col
    @max_col = c if c > @max_col
  end

  def empties
    width = @max_row - @min_row + 1
    length = @max_col - @min_col + 1
    return length * width - @elves.length
  end

  def elf_at(loc)
    return @elves.include?(loc)
  end

  def to_s
    for r in @min_row..@max_row
      row = ""
      for c in @min_col..@max_col
        row += elf_at([r, c]) ? "#" : "."
      end
      puts row
    end
  end
end
