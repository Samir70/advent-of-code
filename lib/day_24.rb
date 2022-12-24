class Solution24
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @width = nil
    @height = nil
    @lcm = nil
    @storm_at = []
    process
    for r in -1..@height
      row = []
      for c in -1..@width
        row << Set.new()
      end
      @storm_at << row
    end
  end

  attr_reader :width, :height, :lcm, :storm_at

  def run
    find_storm_times
    loc = [1, 2, 0] #row, col, time
    visited = Set.new()
    visited.add(loc)
    new_stack = [loc]
    stack = []
    max_r = 0
    while new_stack.length > 0
      stack = [].concat(new_stack)
      new_stack = []
      while stack.length > 0
        r, c, t = stack.pop()
        t += 1
        t_mod = t % @lcm
        new_stack << [r, c, t] if !visited.include?([r, c, t_mod]) && !@storm_at[r][c].include?(t_mod)
        # puts "i was at #{[r, c]} at time #{t - 1}"
        neighbours = Point2D.neighbours(r, c)
        neighbours.each do |nr, nc|
          return t if (nr == @height + 2) && (nc == @width + 1)
          next if nr<2 || nr > @height + 1 || nc < 2 || nc > @width + 1 || visited.include?([nr, nc, t_mod])
          # puts "considering #{[nr, nc]} time #{t}" if nr >= max_r
          if !@storm_at[nr][nc].include?(t_mod)
            # puts "can go to #{[nr, nc]}"
            max_r = nr if nr > max_r
            visited.add([nr, nc, t_mod])
            new_stack << [nr, nc, t]
          end
        end
      end
    end
    display(visited)
    return nil
  end


  def display(s)
    h = {}
    s.each do |r, c, t|
      h[[r, c]] = [] if h[[r, c]] == nil
      h[[r, c]] << t
    end
    h.keys.each do |k|
      puts "#{k} => #{h[k]}"
    end
  end
  def find_storm_times
    for r in 1..@height
      for c in 1..@width
        dir = @data[r][c]
        next if dir == "."
        v_times = visit_times(dir, [r + 1, c + 1])
        # puts "dir at #{[r+1, c+1]} is #{dir}"
        base = v_times[:row][:base]
        v_times[:row][:times].each_with_index do |v_time, i|
          next if v_time == nil
          while v_time < @lcm
            # puts "storm visits #{[r+1, i + 2]} at time #{v_time}"
            @storm_at[r + 1][i + 2].add(v_time)
            v_time += base
          end
        end
        base = v_times[:col][:base]
        v_times[:col][:times].each_with_index do |v_time, i|
          next if v_time == nil
          while v_time < @lcm
            # puts "storm visits #{[i+2, c+1]} at time #{v_time}"
            @storm_at[i + 2][c + 1].add(v_time)
            v_time += base
          end
        end
      end
    end
  end

  def run_2
  end

  def visit_times(dir, loc)
    r, c = loc
    r -= 2
    c -= 2
    rows = Array.new(@width)
    cols = Array.new(@height)
    base = nil
    case dir
    when ">"
      base = @width
      rows.each_with_index { |val, i| rows[i] = (i - c) % @width }
      cols[r] = 0
    when "^"
      base = @height
      rows[c] = 0
      cols.each_with_index { |val, i| cols[i] = (r - i) % @height }
    when "<"
      base = @width
      rows.each_with_index { |val, i| rows[i] = (c - i) % @width }
      cols[r] = 0
    when "v"
      base = @height
      rows[c] = 0
      cols.each_with_index { |val, i| cols[i] = (i - r) % @height }
    end
    return {
             :row => { :base => base, :times => rows },
             :col => { :base => base, :times => cols },
           }
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    @width = @data[0].length - 2
    @height = @data.length - 2
    @lcm = @width.gcdlcm(@height)[1]
  end
end

class Point2D
  def initialize(r, c)
    @r = r
    @c = c
  end

  def loc
    return [@r, @c]
  end

  def above
    return [@r - 1, @c]
  end

  def below
    return [@r + 1, @c]
  end

  def right
    return [@r, @c + 1]
  end

  def left
    return [@r, @c - 1]
  end

  def self.neighbours(r, c)
    return [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]]
  end
end
