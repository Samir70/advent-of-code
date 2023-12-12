Report = Struct.new(:springs, :counts, :totalDamaged, :currentCount)

class Solution12
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @memo = {}
    process
  end

  def countDamaged(str)
    out = []
    count = 0
    str.split("").each do |char|
      if char === "#"
        count += 1
      else
        out << count if count > 0
        count = 0
      end
    end
    out << count if count > 0
    return out
  end

  def parse(line)
    springs, counts = line.split(" ")
    counts = counts.split(",").map(&:to_i)
    sum = counts.sum
    return Report.new(springs, counts, sum, countDamaged(springs))
  end

  def countWays(report, startIndex)
    return 1 if report.counts === report.currentCount
    ways = 0
    (startIndex...report.springs.length).each do |i|
      if report.springs[i] === "?"
        report.springs[i] = "#"
        newCount = countDamaged(report.springs)
        # puts "thinking of change to: #{report.springs}, newCount: #{newCount}"
        ways += 1 * countWays(Report.new(report.springs, report.counts, report.totalDamaged, newCount), i + 1)
        report.springs[i] = "?"
      end
    end
    return ways
  end

  def unfold(str)
    springs, counts = str.split(" ")
    counts = counts.split(",")
    return ([springs] * 5).join("?") + " " + (counts * 5).join(",")
  end

  def findGoodStr(arr)
    return arr.map { |n| "#" * n }.join(".")
  end

  def countWays2(a, b)
    return b.include?("#") ? 0 : 1 if a.length === 0
    return 0 if b.length === 0
    key = [*a, b].join("-")
    return @memo[key] if @memo[key] != nil
    # puts "cw2: #{[a, b]}"
    ways = 0
    wildCount = 0
    indexOfHash = -1
    foundfirst = false
    b.split("").each.with_index do |char, i|
      if char === "?"
        wildCount += 1
      elsif char === "#"
        indexOfHash = i if indexOfHash == -1
        wildCount += 1
      else
        break ways if indexOfHash >= 0
        indexOfHash = -1
        wildCount = 0
      end
      if wildCount >= a[0]
        if i + 1 < b.length && ".?".include?(b[i + 1])
          ways += 1 * countWays2(a[1..], b[i + 2..])
          foundfirst = true
        elsif i === b.length - 1 && a.length === 1
          ways += 1
        end
        # puts "h:w #{[indexOfHash, wildCount]}, i: #{i}, ways: #{ways}"
        return 0 if indexOfHash >= 0 && i + 1 - indexOfHash > a[0]
        break if indexOfHash >= 0 && foundfirst && i + 1 - indexOfHash >= a[0]
      end
    end

    # puts "cw2: #{[a, b]} => #{ways}"
    @memo[key] = ways
    return ways
  end

  def run
    sum = 0
    @data.each do |line|
      report = parse(line)
      # ways = countWays(report, 0)
      ways2 = countWays2(report.counts, report.springs)
      # puts "#{line} should be #{ways} not #{ways2}" if ways != ways2
      sum += ways2
    end
    return sum
  end

  def run_2
    sum = 0
    @data.each.with_index do |line, i|
      line = unfold(line)
      report = parse(line)
      ways = countWays2(report.counts, report.springs)
      # puts "doing line #{i} => ways: #{ways}"
      sum += ways
    end
    return sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
