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
      col = @data.map {|el| el[j]}
      vis_trees = vis_trees.concat(visible(col, "col", j))
      vis_trees = vis_trees.concat(visible(col.reverse, "col-rev", j))
    end
    return vis_trees.uniq.length
  end

  def run_2
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
