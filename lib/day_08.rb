class Solution08
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    # puts "#{@data}"
    vis_trees = []
    @data.each_with_index do |arr, i|
      vis_trees = vis_trees.concat(visible(arr, "row", i))
      vis_trees = vis_trees.concat(visible(arr.reverse, "row-rev", i))
    end
    @data.each_index do |j|
      col = @data.map { |el| el[j] }
      vis_trees = vis_trees.concat(visible(col, "col", j))
      vis_trees = vis_trees.concat(visible(col.reverse, "col-rev", j))
    end
    return vis_trees.uniq.length
  end

  def run_2
    max = 0
    r = 0
    while r < @data.length
      c = 0
      while c < @data[0].length
        s = scenic_score(r, c)
        # puts "score for #{[r, c]} is #{s}"
        if s > max
          max = s
        end
        c += 1
      end
      r += 1
    end
    return max
  end

  def on_grid?(r, c)
    if r < 0
      return false
    elsif c < 0
      return false
    elsif r >= @data.length
      return false
    elsif c >= @data[0].length
      return false
    end
    return true
  end

  def count_from(tree, dir)
    count = 0
    r, c = tree
    dr, dc = dir
    height = @data[r][c]
    while on_grid?(r, c)
      r += dr
      c += dc
      if on_grid?(r, c)
        count += 1
      end
      if on_grid?(r, c) && @data[r][c] >= height
        r = -1
      end
    end
    return count
  end

  def scenic_score(r, c)
    up = count_from([r, c], [-1, 0])
    down = count_from([r, c], [1, 0])
    left = count_from([r, c], [0, -1])
    right = count_from([r, c], [0, 1])
    return up * down * left * right
  end

  def make_key(dir, i, j, len)
    if dir.start_with?("row")
      if dir == "row"
        return "#{i}-#{j}"
      else
        return "#{i}-#{len - j - 1}"
      end
    else
      if dir == "col"
        return "#{j}-#{i}"
      else
        return "#{len - j - 1}-#{i}"
      end
    end
  end

  def visible(arr, direction, i)
    count = []
    max = -1
    arr.each_with_index do |tree, j|
      if tree > max
        max = tree
        count << make_key(direction, i, j, arr.length)
      end
    end
    return count
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map { |el| el.split("") }.map { |el| el.map(&:to_i) }
    file.close
  end
end
