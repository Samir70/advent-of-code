Point = Struct.new(:r, :c, :visited)

class Solution12
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
    @height = @data.length
    @width = @data[0].length
    @dist_from_e = []
    @height.times do
      row = Array.new(@width, 100000)
      @dist_from_e << row
    end
    @stack = []
    @new_stack = []
  end

  attr_reader :dist_from_e, :stack, :new_stack

  def run(r, c)
    return "ERROR, not S" if @data[r][c] != "S"
    find_e
    count = 0
    while @stack.length > 0 || @new_stack.length > 0 do
      @stack = @new_stack.uniq.select {|sq| @dist_from_e[sq[0]][sq[1]] == 100000 || @dist_from_e[sq[0]][sq[1]] == 0}
      @new_stack = []
      if count % 100 == 0
        # puts "#{count} has stack length #{@stack.length}"
        # puts "#{stack[0..5]}"
      end
      while @stack.length > 0 do
        i, j = @stack.pop
        update_dists(i, j)
        # if i == r && j == c
        #   return @dist_from_e[r][c]
        # end
      end
      count += 1
    end
    return @dist_from_e[r][c]
  end

  def run_2(r, c)
    run(r, c)
    min_dist = 9999
    for r in 0...@height do
      for c in 0...@width do
        if altitude(@data[r][c]) == 1 
          min_dist = @dist_from_e[r][c] if @dist_from_e[r][c] < min_dist
          # puts "found an a: #{[r, c]}, shortest found is #{min_dist}"
        end
      end
    end
    return min_dist
  end

  def find_e
    for r in 0...@height
      for c in 0...@width
        if @data[r][c] == "E"
          @dist_from_e[r][c] = 0
          @new_stack << [r, c]
          # puts "#{@dist_from_e}"
          return true
        end
      end
    end
    return false
  end

  def update_dists(r, c)
    ns = can_go_to_from(r, c)
    dists = ns.map { |el| @dist_from_e[el[0]][el[1]] + 1 }
    nearest = dists.min
    # puts "updating dists from #{[r, c]}, dists = #{dists}"
    if nearest < @dist_from_e[r][c]
      @dist_from_e[r][c] = nearest 
      # puts "found dist from #{[r, c]} = #{nearest}"
    end
    @new_stack.concat(poss_previous(r, c))
    # @dist_from_e[(r-2)..(r+2)].each {|row| puts "#{row[(c-5)..(c+5)]}"}
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
