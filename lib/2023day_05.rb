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

  def mapRange(m, r)
    out = []
    a, b = r
    return [] if a >= b
    diff = m[0] - m[1]
    sourceStart = m[1]
    sourceEnd = m[1] + m[2] - 1
    destStart = m[0]
    destEnd = sourceEnd + diff
    return [a, b] if a > sourceEnd
    if a < sourceStart
      if b < sourceStart
        out << [a, b]
      else
        out << [a, sourceStart - 1]
        out += mapRange(m, [sourceStart, b])
      end
    end

    if a >= sourceStart
      if b <= sourceEnd
        out << [a + diff, b + diff]
      else
        out << [a+diff, destEnd]
        out << [sourceEnd + 1, b]
      end
    end

    return out
  end

  def run_2
    pairs = getPairs(@data[0].split(":")[1].split(" ").map(&:to_i))
    maps = getMaps
    maps.each do |ms|
      newPairs = []
      pairs.each do |p|
        
      end
    end
    return seeds.min
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
