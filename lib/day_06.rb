class Solution06
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @buffer = ""
    process
  end

  def run(n, len)
    @buffer = @data[n]
    i = 0
    while i <= @buffer.length - len
      # puts "checking #{@buffer[i-3, 4]}"
      if unique(@buffer[i, len])
        return i + len
      end
      i += 1
    end
    return nil
  end

  def unique(str)
    arr = str.split("").uniq
    return arr.length == str.length
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
