class Solution25
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    decimals = @data.map {|snafu| snafu2decimal(snafu)}
    sum = decimals.sum
    return pental2snafu(decimal2pental(sum))
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end

def snafu_digits(s)
  snafu = "210-="
  digits = [2, 1, 0, -1, -2]
  return s.split("").map { |d| snafu.index(d) }.map { |d| digits[d] } if s.class == String
  return s.map { |d| digits.index(d) }.map { |d| snafu[d] }.join("") if s.class == Array
end

def snafu2decimal(s)
  digits = snafu_digits(s).reverse
  out = 0
  col = 1
  digits.each do |d|
    out += d * col
    col *= 5
  end
  return out
end

def pental2snafu(s)
  num = s.class == String ? s.split("").map(&:to_i) : [].concat(s)
  # puts "converting #{num}"
  if num.first > 2
    num[0] -= 5
    num.unshift(1)
  end
  col = 1
  while col < num.length do
    if num[col] > 2
      num[col] -= 5
      num[col - 1] += 1
      return pental2snafu(num)
    end
    col += 1
  end
  return snafu_digits(num)
end

def decimal2pental(num)
  return num.to_s if num < 5
  return decimal2pental(num / 5) + (num % 5).to_s
end
