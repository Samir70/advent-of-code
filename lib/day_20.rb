class Solution20
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    m = MyList.new(@data)
    m.mix
    return [1000, 2000, 3000].map {|el| m.get(el)}.sum
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map(&:to_i)
    file.close
  end
end

class MyList
  def initialize(arr)
    @arr = arr.map { |el| [el, false] }
  end
  
  def list
    return @arr.map {|el| el[0]}
  end

  def mix
    len = @arr.length
    done = 0
    i = 0
    while done < len do
      i += 1 while @arr[i][1] 
      val = @arr[i][0]
      destination = i + val
      destination += len - 1 while destination <= 0 
      destination -= len - 1 while destination >= len
      if i < destination
        @arr.delete_at(i)
        @arr.insert(destination, [val, true])
      elsif destination < i
        @arr.delete_at(i)
        @arr.insert(destination, [val, true])
      else
        @arr[i] = [val, true]
      end
      # puts "i, val, dest: #{[i, val, destination]} gives #{list}"
      done += 1
    end
  end

  def get(n)
    idx_zero = @arr.index { |el| el[0] == 0 }
    return nil if idx_zero == nil
    return @arr[(n + idx_zero) % @arr.length][0]
  end
end
