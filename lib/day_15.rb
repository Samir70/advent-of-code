require "date"

class Solution15
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @beacons = []
    @sensors = []
    process
  end

  def run(row_wanted)
    start = DateTime.now()
    intervals = []
    beacons__on_row_wanted = Set.new()

    @data.each do |str|
      s, b = extract_points(str)
      # puts "found sensor at #{s}, beacon at #{b}"
      @sensors << s
      @beacons << b
      beacons__on_row_wanted.add(b) if b[0] == row_wanted
      d = m_dist(s, b)
      no_beacons_at_row = manhattan_circle(s, d).select { |el| el[row_wanted] != nil }
      # puts "#{no_beacons_at_row}"
      intervals << no_beacons_at_row[0][row_wanted] if no_beacons_at_row.length > 0
      # puts "#{intervals}"
      # puts "found #{beacons__on_row_wanted} beacons on #{row_wanted}"
      # puts ""
    end
    merged = merge_intervals(intervals)
    # puts "#{intervals}"
    # puts "#{merged}"
    # puts "found #{beacons__on_row_wanted} beacons on #{row_wanted}"
    end_time = DateTime.now()
    puts "#{end_time} - #{start} = #{(end_time - start).to_f * 24*3600}"
    return merged.map { |el| el[1] - el[0] + 1 }.sum - beacons__on_row_wanted.size
  end

  def run_2(max_row)
    start = DateTime.now()
    intervals = {}

    @data.each do |str|
      s, b = extract_points(str)
      # puts "found sensor at #{s}, beacon at #{b}"
      # @sensors << s
      # @beacons << b
      d = m_dist(s, b)
      no_beacons_at = manhattan_circle(s, d)
      no_beacons_at.each do |row_info|
        key = row_info.keys[0]
        next if key < 0 || key > max_row
        # puts "row_info for sensor #{s}, dist = #{d}::: #{key} => #{row_info[key]}"
        if intervals[key] == nil
          intervals[key] = []
        end
        intervals[key].concat([row_info[key]])
      end
      # puts "#{intervals}"
    end
    intervals.each do |interval|
      key, interval_list = interval
      next if key < 0 || key > max_row
      interval_list = merge_intervals(interval_list)
      # puts "Interval in loop is: #{key} :: #{interval_list}"
      if interval_list.length == 2
        x = interval_list[0][1] + 1
        y = key
        end_time = DateTime.now()
        puts "#{end_time} - #{start} = #{(end_time - start).to_f * 24*3600}"
        return x * 4000000 + y
      end
    end
    return nil
  end

  def merge_intervals(arr)
    out = []
    cur = arr.sort_by! { |el| el[0] }.first
    i = 1
    while i < arr.length
      c2 = arr[i]
      if c2[0] <= cur[1] + 1
        cur[1] = [cur[1], c2[1]].max
      else
        out << cur
        cur = c2
      end
      i += 1
    end
    out << cur
    return out
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
