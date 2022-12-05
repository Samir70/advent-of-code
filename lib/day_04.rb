class Solution04
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
  end

  def get_intervals(str)
    a, b = str.split(",").map { |el| el.split("-").map(&:to_i) }
    return [a, b]
  end

  def has_subset?(a, b)
    if a[0] <= b[0] && a[1] >= b[1]
      return true
    end
    if b[0] <= a[0] && b[1] >= a[1]
      return true
    end
    return false
  end

  def count_subsets
    count = 0
    @data.each do |pair|
      if has_subset?(pair[0], pair[1])
        count += 1
      end
    end
    return count
  end

  def has_overlap?(a, b)
    if b[0] >= a[0] && b[0] <= a[1]
      return true
    end
    if a[0] >= b[0] && a[0] <= b[1]
      return true
    end
    return false
  end

  def count_overlaps
    count = 0
    @data.each do |pair|
      if has_overlap?(pair[0], pair[1])
        count += 1
      end
    end
    return count
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map { |el| get_intervals(el) }
    file.close
  end

  def show_data
    @data.each { |d| puts "#{d}" }
  end
end
