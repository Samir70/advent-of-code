class Solution06
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getRaces
    races = []
    nums = @data.map do |line|
      line.split(":")[1].split(" ").map(&:to_i)
    end
    # puts "#{nums}"
    nums[0].length.times do |i|
      races << [nums[0][i], nums[1][i]]
      # puts "#{i}: #{races}"
    end
    return races
  end

  def calcMinHold(time, dist)
    left = 1
    right = time
    while left < right
      mid = left + ((right - left)/2).floor
      if mid * (time - mid) <= dist
        left = mid + 1
      else 
        right = mid
      end
    end
    return left
  end

  def ways2win(time, dist)
    min = calcMinHold(time, dist)
    # puts "#{time}, #{dist} => #{min} => #{(time - min) - min + 1}"
    # time - min = max time you can hold
    return (time - min) - min + 1
  end

  def run
    prod = 1
    # puts "run: #{getRaces}"
    # w2w = getRaces.map {|race| ways2win(*race)}
    # puts "w2w: #{w2w}"
    getRaces.map {|race| ways2win(*race)}.each {|w| prod *= w}
    return prod
  end

  def bigrace
    return @data.map {|line| line.split(":")[1].split(" ").join("").to_i}
  end

  def run_2
    return ways2win(*bigrace)
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
