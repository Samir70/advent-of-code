class Solution09
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def findNext(nums)
    diffs = []
    n = nums.length
    allZeroes = true
    (1...n).each do |i|
      diff = nums[i] - nums[i - 1]
      allZeroes = false if diff != 0
      diffs << diff
      # puts "#{i} out of #{n}"
    end
    # puts "#{nums} => #{diffs}"
    return allZeroes ? nums[0] : nums[-1] + findNext(diffs)
  end

  def run
    sum = 0
    @data.each do |line|
      sum += findNext(line.split(" ").map(&:to_i))
    end
    return sum
  end
  
  def run_2
    sum = 0
    @data.each do |line|
      sum += findNext(line.split(" ").reverse().map(&:to_i))
    end
    return sum
  
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
