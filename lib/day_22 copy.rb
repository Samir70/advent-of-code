require_relative "../utils/grid_from_strings"

class Solution22
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @instructions = []
    # @points = []
    @faces = []
    @cube_size = 0
    process
    # @grid = HashGrid.new(@points)
    @loc = [0, 0, 0] #face, row, col
  end

  attr_reader :instructions, :loc, :faces

  def run
    d = Direction.new()
    puts "starting from #{@loc}"
    @instructions.each do |step|
      if step == "L" || step == "R"
        d.change(step)
      else
        step.times do
          # case d.dir
          # when 0
          #   @loc = @grid.step_right(@loc[0], @loc[1])
          # when 1
          #   @loc = @grid.step_down(@loc[0], @loc[1])
          # when 2
          #   @loc = @grid.step_left(@loc[0], @loc[1])
          # when 3
          #   @loc = @grid.step_up(@loc[0], @loc[1])
          # end
        end
      end
      # puts "Followed step #{step}\nNow at #{@loc}, facing dir #{d.dir}"
    end
    r, c = @loc
    # puts "finished at #{[r, c]} with direction #{d.dir}"
    return 1000 * r + 4 * c + d.dir
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    # r = 1
    # @data[0..-2].each do |line|
    #   for c in 0...(line.length)
    #     @points << [r, c + 1, line[c]] if line[c] != " "
    #   end
    #   r += 1
    # end
    @instructions = split_instructions(@data.last)
    cube_size = (@data.length - 2) / 3
    @cube_size = cube_size
    @faces << Face.new(1, @data[0...cube_size].map { |s| s[(cube_size * 2)..(cube_size * 3)] })
    @faces << Face.new(2, @data[(cube_size)...(cube_size * 2)].map { |s| s[(0)...(cube_size)] })
    @faces << Face.new(3, @data[(cube_size)...(cube_size * 2)].map { |s| s[(cube_size)...(cube_size * 2)] })
    @faces << Face.new(4, @data[(cube_size)...(cube_size * 2)].map { |s| s[(cube_size * 2)...(cube_size * 3)] })
    @faces << Face.new(5, @data[(cube_size * 2)...(cube_size * 3)].map { |s| s[(cube_size * 2)...(cube_size * 3)] })
    @faces << Face.new(6, @data[(cube_size * 2)...(cube_size * 3)].map { |s| s[(cube_size * 3)...(cube_size * 4)] })
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
      [0, 1], [1, 0], [0, -1], [-1, 0], #rdlu
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

class Face
  def initialize(face_num, arr)
    @face_num = face_num
    @rows = arr
    # @teleport = Teleports[face_num]
  end

  attr_reader :rows
  def move(d, r, c)
    nr, nc = add_vector(d.vector, [r, c])
  end
end
