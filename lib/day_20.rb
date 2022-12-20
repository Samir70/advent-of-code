class Solution20
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    m = MyList.new(@data)
    m.mix
    return [1000, 2000, 3000].map { |el| m.get(el) }.sum
  end

  def run_2
    m = MyList.new(@data.map {|el| el * 811589153})
    10.times do
      m.mix
      # puts "list is: #{m.list}"
    end
    return [1000, 2000, 3000].map { |el| m.get(el) }.sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map(&:to_i)
    file.close
  end
end

class MyList
  def initialize(arr)
    @arr = arr.map.with_index(0) { |el, i| { val: el, jump: el % (arr.length - 1), new_idx: i } }
  end

  def list
    arr = [].concat(@arr)
    # arr.each do |el|
    #   puts el
    # end
    return arr.sort_by! {|el| el[:new_idx] }.map { |el| el[:val] }
  end

  def normalise(val, base)
    val += base while val <= 0
    val -= base while val > base
    return val
  end

  def mix
    len = @arr.length
    len.times do |i|
      cur = @arr[i]
      # puts "cur: #{cur}"
      dest = normalise(cur[:new_idx] + cur[:jump], len - 1)
      @arr.each do |el|
        # puts "thinking about changing: #{el}"
        if  cur[:new_idx] < dest
          if cur[:new_idx] < el[:new_idx] && el[:new_idx] <= dest
            el[:new_idx] -= 1
          end
        elsif dest < cur[:new_idx]
          if dest <= el[:new_idx] && el[:new_idx] < cur[:new_idx]
            el[:new_idx] += 1
          end
        end
        # puts "it has become:           #{el}"
      end
      cur[:new_idx] = dest
      # puts "cur: #{cur}"
      # puts "#{list}"
    end
  end

  def get(n)
    idx_zero = @arr.select { |el| el[:val] == 0 }[0][:new_idx]
    return nil if idx_zero == nil
    target_index = (n + idx_zero) % @arr.length
    # puts "idx of zero is #{idx_zero}, target: #{target_index}"
    return @arr.select { |el| el[:new_idx] == target_index }[0][:val]
  end
end
