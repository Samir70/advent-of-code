class Solution15
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
  end

  def run_2
  end

  def get_x(str)
    return str.split(",")[0].split("x=")[1].to_i
  end

  def get_y(str)
    return str.split(",")[1].split("y=")[1].to_i
  end

  def extract_points(str)
    # Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    s, b = str.split(":")
    return [[get_y(s), get_x(s)], [get_y(b), get_x(b)]]
  end

  def m_dist(a, b)
    return (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def manhattan_circle(point, radius)
    r, c = point
    intervals = [{ r => [c - radius, c + radius] }]
    dr = 1
    while dr <= radius
      intervals << { (r + dr) => [c - radius + dr, c + radius - dr] }
      intervals << { (r - dr) => [c - radius + dr, c + radius - dr] }
      dr += 1
    end
    return intervals
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
