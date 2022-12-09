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
      # puts "After #{str}: #{@knots}"
    end
  end

  def update_tail(head, tail)
    hr, hc = head
    tr, tc = tail
    if hr == tr
      if tc == hc || tc == hc + 1 || tc == hc - 1
        return tail
      elsif hc - tc > 1
        return [tr, tc + 1]
      elsif tc - hc > 1
        return [tr, tc - 1]
      end
    elsif hc == tc
      if tr == hr || tr == hr + 1 || tr == hr - 1
        return tail
      elsif hr - tr > 1
        return [tr + 1, tc]
      elsif tr - hr > 1
        return [tr - 1, tc]
      end
    else # Neither the col nor row are the same
      if Math.hypot(hr - tr, hc - tc) < 2
        return tail
      elsif hr > tr && hc > tc # above right
        return [tr + 1, tc + 1]
      elsif hr > tr && hc < tc # above left
        return [tr + 1, tc - 1]
      elsif hr < tr && hc > tc # below right
        return [tr - 1, tc + 1]
      elsif hr < tr && hc < tc # below left
        return [tr - 1, tc - 1]
      end
    end
    return tail
  end

  def add_vector(a, b)
    # puts "adding #{a} and #{b}"
    return [a[0] + b[0], a[1] + b[1]]
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
