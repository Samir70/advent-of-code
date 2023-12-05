require_relative "../utils/utils"
MapList = Struct.new(
  :seed2soil, :soil2fert, :fert2water,
  :water2light, :light2temp, :temp2humid, :humid2loc
)

class Solution05
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def processSection(arr)
    out = []
    arr.each do |line|
      next if line.include?("seeds")
      next if line.include?("map")
      out.push(line.split(" ").map(&:to_i))
    end
    return out
  end

  def getMaps
    maps = []
    sections = split_by_element(@data, "").map do |el|
      processSection(el)
    end
    return MapList.new(*sections[1..7])
  end

  def followMap(m, n)
    diff = m[0] - m[1]
    return n < m[2] + m[1] && m[1] <= n ? n + diff : n
  end

  def followMaps(ms, n)
    ms.each do |m|
      d = followMap(m, n)
      return d if d != n
    end
    return n
  end

  def run
    seeds = @data[0].split(":")[1].split(" ").map(&:to_i)
    maps = getMaps
    maps.each do |ms|
      seeds = seeds.map do |s|
        followMaps(ms, s)
      end
    end
    return seeds.min
  end

  def getPairs(arr)
    out = []
    i = 0
    while i < arr.length
      out.push([arr[i], arr[i + 1]])
      i += 2
    end
    return out
  end

  def pair2range(p)
    return [p[0], p[0] + p[1] - 1]
  end

  def map2interval(m)
    a, b, c = m
    return [b, b + c - 1, a - b]
  end

  def makeRange(intervalDiff)
    return [intervalDiff[0] + intervalDiff[2], intervalDiff[1] + intervalDiff[2]]
  end

  def processRange(intervals, left, right)
    out = []
    intervals.each do |interval|
      a, b, diff = interval
      while left <= right && left <= b
        if left < a
          bestEnd = [a - 1, right].min
          out << [left, bestEnd]
          left = bestEnd + 1
        elsif left < b
          bestEnd = [b, right].min
          out << [left + diff, bestEnd + diff]
          left = bestEnd + 1
        else
          out << [left, right]
          left = right + 1
        end
      end
    end
    out << [left, right] if left <= right
    return out
  end

  def run_2
    ranges = getPairs(@data[0].split(":")[1].split(" ").map(&:to_i)).map do |p|
      pair2range(p)
    end
    maps = getMaps
    maps.each do |ms|
      intervals = ms.map do |m|
        map2interval(m)
      end
      intervals.sort_by! { |i| i[0] }
      # puts "#{intervals}, #{ranges[0]}"
      newPairs = []
      ranges.each do |range|
        newPairs += processRange(intervals, *range)
      end
      ranges = [*newPairs]
    end
    return ranges.map {|el| el[0]}.min
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
