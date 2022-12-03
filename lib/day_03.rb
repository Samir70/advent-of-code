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

  def splitRucks(index)
    @data.map! do |word|
      [word[0, word.length / 2], word[word.length / 2, word.length]]
    end
    return @data[index]
  end

  def overlap(a, b)
    b.split("").each do |char|
      if a.include?(char)
        return char
      end
    end
    return nil
  end

  def overlaps
    splitRucks(0)
    return @data.map { |el| overlap(el[0], el[1]) }.map { |el| priority(el)}
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
