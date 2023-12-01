class Solution01
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    nums = []
    @data.each do |line|
      num = ""
      line.split("").each do |char|
        if char.match?(/[0-9]/)  
          num = num == "" ? char : num[0] + char
        end
      end
      if num.length === 1
        num = num + num
      end
      nums.push(num.to_i)
    end
    return nums.sum
  end

  def run_2
    nums = []
    digits = [
      "zero", "one", "two", "three", "four", "five",
      "six", "seven", "eight", "nine",
      "1", "2", "3", "4", "5",
      "6", "7", "8", "9", "0", 
    ]
    
    @data.each do |line|
      num = "ab"
      first = 100000000
      last = -1
      digits.each.with_index do |d, i|
        pos = line.index(d)
        if pos != nil
          if pos < first
            first = pos
            num[0] = d.length > 1 ? i.to_s : d
          end
          # puts "line: #{line}, digit: #{d}, pos: #{pos}, num: #{num}, i: #{i}"
        end
        pos = line.rindex(d)
        if pos != nil
          if pos > last
            last = pos
            num[1] = d.length > 1 ? i.to_s : d
          end
        end
      end
      puts num
      nums.push(num.to_i)
    end
    return nums.sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end

