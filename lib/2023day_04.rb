Card = Struct.new(:winning, :have)

class Solution04
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @cardCounts = []
    process
  end

  def getNums(line)
    w, h = line.split(":")[1].split("|")
    return Card.new(w.split(" ").map(&:to_i), h.split(" ").map(&:to_i))
  end

  def countWins(w, h)
    wins = 0
    h.each do |n|
      wins += 1 if w.include?(n)
    end
    return wins
  end

  def run
    sum = 0
    @data.each do |line|
      nums = getNums(line)
      wins = countWins(nums.winning, nums.have)
      sum += 2 ** (wins - 1) if wins > 0
      # puts "#{line} wins: #{wins} #{sum}"
    end
    return sum
  end
  
  def run_2
    @data.each.with_index do |line, i|
      nums = getNums(line)
      wins = countWins(nums.winning, nums.have)
      # puts "#{line} wins: #{wins}"
      ((i + 1)...(i + wins+1)).each do |j|
        # puts j
        @cardCounts[j] += @cardCounts[i]
      end
    end
    return @cardCounts.sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    @cardCounts = Array.new(@data.length, 1)
    file.close
  end
end
