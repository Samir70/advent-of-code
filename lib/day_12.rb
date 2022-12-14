Point = Struct.new(:r, :c, :visited)

class Solution12
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
    @height = @data.length
    @width = @data[0].length
    @dist_from_s = []
    @height.times do
      row = Array.new(@width, 100000)
      @dist_from_s << row
    end
    @stack = []
    @new_stack = []
  end

  attr_reader :dist_from_e, :stack, :new_stack

  def run(r, c)
    # return "ERROR, not S" if @data[r][c] != "S"
    queue = Set.new()
    # prevs = {}
    for i in 0...@height
      for j in 0...@width
        queue.add([i, j])
        @dist_from_s[i][j] = 100000
      end
    end
    @dist_from_s[r][c] = 0

    while queue.size > 0
      cur = queue.min_by { |el| @dist_from_s[el[0]][el[1]] }
      r, c = cur
      # if @dist_from_s[r][c] < 427
      #   puts "min from queue: #{cur}  #{@data[r][c]} has dist #{@dist_from_s[r][c]}"
      #   # neighbours = can_go_to_from(r, c)
      #   # puts "#{neighbours}"
      # end
      queue.delete(cur)
      if @data[r][c] == "E"
        return @dist_from_s[r][c]
      end

      neighbours = can_go_to_from(r, c)
      neighbours.each do |n|
        i, j = n
        alt = @dist_from_s[r][c] + 1
        @dist_from_s[i][j] = alt if @dist_from_s[i][j] > alt
      end
    end

    return @dist_from_s[r][c]
  end

  def run_2
    dists_from_as = []
    for r in 0...@height do
      for c in 0...@width do
        if altitude(@data[r][c]) == 1 
          dists_from_as << run(r, c)
          puts "found an a: #{[r, c]}, now found #{dists_from_as.length}"
        end
      end
    end
    return dists_from_as.min
  end

  def altitude(char)
    return 1 if char == "S"
    return 26 if char == "E"
    return "SabcdefghijklmnopqrstuvwxyzE".index(char)
  end

  def can_go_to_from(r, c)
    # squares you can continue to
    alt_here = altitude(@data[r][c])
    dirs = [
      [-1, 0], [1, 0], [0, -1], [0, 1],
    ]
    out = []
    dirs.each do |d|
      nr, nc = [d[0] + r, d[1] + c]
      # puts "here: #{[r, c]} altitude:#{alt_here}"
      # puts "d: #{d} => n #{[nr, nc]}"
      if (nr >= 0 && nr < @height && nc >= 0 && nc < @width)
        alt_there = altitude(@data[nr][nc])
        # puts "d: #{d} => n #{[nr, nc]}  altitude #{alt_there}"
        if alt_here - alt_there >= -1
          out << [nr, nc]
        end
      end
    end
    return out
  end

  def poss_previous(r, c)
    # squares you can continue to
    alt_here = altitude(@data[r][c])
    dirs = [
      [-1, 0], [1, 0], [0, -1], [0, 1],
    ]
    out = []
    dirs.each do |d|
      nr, nc = [d[0] + r, d[1] + c]
      # puts "here: #{[r, c]} altitude:#{alt_here}"
      # puts "d: #{d} => n #{[nr, nc]}"
      if (nr >= 0 && nr < @height && nc >= 0 && nc < @width)
        alt_there = altitude(@data[nr][nc])
        # puts "d: #{d} => n #{[nr, nc]}  altitude #{alt_there}"
        if alt_there - alt_here >= -1
          out << [nr, nc]
        end
      end
    end
    return out
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
