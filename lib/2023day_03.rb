class Solution03
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def is_digit?(char)
    return "0123456789".index(char).is_a?(Integer)
  end

  def getNums(str)
    out = []
    num = ""
    left = -1
    # .129*56...
    str.split("").each.with_index do |char, i|
      # puts "#{char}, #{i}"
      if is_digit?(char)
        num += char
      elsif num.length > 0
        out.push([num.to_i, left + 1, i - 1])
        num = ""
        left = i
      else
        left = i
      end
    end
    if num.length > 0
      out.push([num.to_i, left + 1, str.length - 1])
    end
    return out
  end

  def hasSymbol?(num, str)
    # symbols = "$%&*-+=#@/"
    # str.split("").each.with_index do |char, i|
    #   if symbols.index(char).is_a?(Integer)
    #     # puts [num[1], i, num[2]]
    #     if i.between?(num[1]-1, num[2]+1)
    #       return true
    #     end
    #   end
    # end
    # return false
    left = [0, num[1] - 1].max
    right = [num[2] + 1, str.length - 1].min
    for i in left..right
      # puts "char: #{str[i]}, i: #{i}, range:#{[left, right]}, num: #{num}"
      if str[i] != "." && !is_digit?(str[i])
        return true
      end
    end
    return false
  end

  def run
    sum = 0
    @data.each.with_index do |line, i|
      nums = getNums(line)
      nums.each do |num|
        if hasSymbol?(num, line)
          sum += num[0]
        elsif i > 0 && hasSymbol?(num, @data[i - 1])
          sum += num[0]
        elsif i < @data.length - 1 && hasSymbol?(num, @data[i + 1])
          sum += num[0]
        else
          # puts "No symbol by #{num}, #{i}"
          # puts "#{@data[i - 1][num[1]-1..num[2]+1]}"
          # puts "#{line[num[1]-1..num[2]+1]}"
          # puts "#{@data[i + 1][num[1]-1..num[2]+1]}"
        end
      end
    end
    return sum
  end

  def findStars
    out = []
    @data.each.with_index do |line, di|
      for li in 0...line.length 
        if line[li] == "*"
          out.push([di, li])
        end
      end
    end
    return out
  end

  def run_2
    sum = 0
    stars = findStars
    stars.each do |star|
      row = star[0]
      col = star[1]
      nums = getNums(@data[row])
      if row > 0 
        nums += getNums(@data[row - 1])
      end
      if row < @data.length - 1
        nums += getNums(@data[row + 1])
      end
      
      found = []
      nums.each do |num|
        left = [0, num[1] - 1].max
        right = [num[2] + 1, @data[row - 1].length - 1].min
        if col.between?(left, right)
          found.push(num[0])
        end
      end
      if found.length == 2
        sum += found[0] * found[1]
      end
    end
    return sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
