require_relative "../utils/utils.rb"
require_relative "../utils/grid_from_strings.rb"

class Solution13
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getPatterns
    return split_by_element(@data, "")
  end

  def calcIntervals(n, m)
    puts "Yep, you do have to do even length!" if n % 2 == 0
    a, b, c, d = 0, 0, 0, n - 1
    if m < (n - 1) / 2
      a, b, c, d = 0, m, m + 1, 2 * m + 1
    else
      numReflected = n - m - 1
      a, b, c, d, = m - numReflected + 1, m, m + 1, m + numReflected
    end
    return [[a, b], [c, d]]
  end

  def findHorMirror(pattern)
    n = pattern.length
    (n - 1).times do |i|
      left, right = calcIntervals(n, i)
      # puts "i: #{i} => #{[left, right]}"
      a, b = left
      c, d = right
      numReflected = b - a + 1
      allSame = true
      numReflected.times do |j|
        # puts "comparing #{[b - j, c + j]}"
        allSame = false if pattern[b - j] != pattern[c + j]
      end
      return c if allSame
    end
    return 0
  end
  def findHorSmudgedMirror(pattern)
    n = pattern.length
    (n - 1).times do |i|
      left, right = calcIntervals(n, i)
      # puts "i: #{i} out of #{n-1} => #{[left, right]}"
      a, b = left
      c, d = right
      numReflected = b - a + 1
      errorCount = 0
      numReflected.times do |j|
        errorCount += countDiffs(pattern[b - j], pattern[c + j])
        # puts "comparing #{[b - j, c + j]}, errorCount #{errorCount}"
      end
      return c if errorCount === 1
    end
    return 0
  end

  def findVertMirror(pattern)
    n = pattern[0].length
    grid = GridFromStrings.new(pattern)
    newPattern = []
    n.times do |c|
      newPattern << grid.getCol(c)
    end
    return findHorMirror(newPattern)
  end
  def findVertSmudgedMirror(pattern)
    n = pattern[0].length
    grid = GridFromStrings.new(pattern)
    newPattern = []
    n.times do |c|
      newPattern << grid.getCol(c)
    end
    return findHorSmudgedMirror(newPattern)
  end

  def countDiffs(a, b)
    n = a.length
    count = 0
    n.times do |i|
      count += 1 if a[i] != b[i]
    end
    return count
  end

  def run
    horSum = 0
    vertSum = 0
    patterns = getPatterns
    patterns.each do |p|
      grid = GridFromStrings.new(p)
      # puts grid
      # puts "H, V => #{[findHorMirror(p), findVertMirror(p)]}"
      horSum += findHorMirror(p)
      vertSum += findVertMirror(p)
    end
    return horSum * 100 + vertSum
  end

  def run_2
    horSum = 0
    vertSum = 0
    patterns = getPatterns
    patterns.each do |p|
      grid = GridFromStrings.new(p)
      # puts grid
      # puts "H, V => #{[findHorMirror(p), findVertMirror(p)]}"
      horSum += findHorSmudgedMirror(p)
      vertSum += findVertSmudgedMirror(p)
    end
    return horSum * 100 + vertSum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
