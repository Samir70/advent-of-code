class Solution03
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    # puts "#{overlaps}"
    return overlaps.sum
  end

  def run_2
    return getBadges.map { |el| priority(el) }.sum
  end

  def splitRucks(index)
    @data.map! do |word|
      [word[0, word.length / 2], word[word.length / 2, word.length]]
    end
    return @data[index]
  end

  def groupIn3s
    groups = []
    group = []
    @data.each do |line|
      group << line
      if group.length == 3
        groups << group
        group = []
      end
    end
    return groups
  end

  def findBadge(a, b, c)
    overlap1 = overlap(a, b).join("")
    return overlap(overlap1, c)[0]
  end

  def getBadges
    groups = groupIn3s
    return groups.map { |g| findBadge(g[0], g[1], g[2]) }
  end

  def overlap(a, b)
    out = []
    b.split("").each do |char|
      if a.include?(char)
        out << char
      end
    end
    return out
  end

  def overlaps
    splitRucks(0)
    return @data.map { |el| overlap(el[0], el[1]) }.map { |el| priority(el[0]) }
  end

  def priority(c)
    s = "-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return s.index(c)
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
