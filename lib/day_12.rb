Point = Struct.new(:r, :c, :visited)

class Solution12
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @dirs = [
      [-1, 0], [1, 0], [0, -1], [0, 1],
    ]
    process
    @height = @data.length
    @width = @data[0].length
  end

  def run(r, c)
    return "ERROR, not S" if @data[r][c] != "S"
    v = Set.new()
    v.add([r, c])
    global_visitied = Set.new()
    global_visitied.add([r, c])
    start = Point.new(r, c, v)
    stack = [start]
    new_stack = []
    successes = []
    while stack.length > 0 || new_stack.length > 0
      cur = stack.pop
      # puts "cur = #{cur}"
      successes << cur.visited.size - 1 if @data[cur.r][cur.c] == "E"
      @dirs.each do |d|
        nr, nc = [d[0] + cur.r, d[1] + cur.c]
        # puts "d: #{d} => n #{[nr, nc]}"
        if !(nr < 0 || nr >= @height || nc < 0 || nc >= @width)
          if !global_visitied.include?([nr, nc])
            alt_here = altitude(@data[cur.r][cur.c])
            alt_there = altitude(@data[nr][nc])
            if alt_there - alt_here < 2
              nv = Set.new(cur.visited)
              nv.add([nr, nc])
              global_visitied.add([nr, nc])
              new_stack << Point.new(nr, nc, nv)
            end
          end
        end
      end
      if stack.length == 0
        stack = Array.new(new_stack)
        # puts "new stack #{new_stack}"
        new_stack = []
      end
    end
    return successes.min
  end

  def dfs(r, c, visited)
    if @data[r][c] == "E"
      puts "At E: #{visited.size}"
      return [true, visited.size]
    end

    puts "at #{[r, c]} == #{@data[r][c]}"

    next_steps = []
    # puts "@dirs = #{@dirs}"
    @dirs.each do |d|
      nr, nc = [d[0] + r, d[1] + c]
      # puts "d: #{d} => n #{[nr, nc]}"
      if !(nr < 0 || nr >= @height || nc < 0 || nc >= @width)
        if !visited.include?([nr, nc])
          alt_here = altitude(@data[r][c])
          alt_there = altitude(@data[nr][nc])
          if alt_there - alt_here < 2
            next_steps << [nr, nc]
          end
        end
      end
    end
    # puts "next_steps: #{next_steps}"
    next_steps.each do |step|
      nv = Set.new(visited)
      nv.add(step)
      outcome = dfs(step[0], step[1], nv)
      return outcome if outcome[0]
      nv.delete(step)
    end
    return [0, 0]
  end

  def altitude(char)
    return "SabcdefghijklmnopqrstuvwxyzE".index(char)
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
