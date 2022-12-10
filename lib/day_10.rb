class Solution10
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @x = [1] # after 0th cycle x contains 1
    process
  end

  attr_reader :x

  def run
    @data.each do |cmd|
      cpu(cmd)
      # puts "#{cmd}, x[#{x.length}-1] #{@x[-1]}"
    end
    # puts "finally #{@x.length}"
    return nil
  end

  def run_2
    crt = ""
    240.times do |i|
      if print?(i+1)
        crt += "#"
      else
        crt += "."
      end
    end
    puts "", crt
    return nil
  end

  def noop
    @x << @x.last
  end

  def addx(instr)
    amount = instr.split(" ")[1].to_i
    noop
    @x << @x.last + amount
  end

  def cpu(instr)
    if instr == "noop"
      noop
    elsif instr.start_with?("addx")
      addx(instr)
    end
  end

  def sig_strength(n)
    val = @x[n-1]
    # puts "x is #{val}, #{@x}"
    return val.nil? ? nil : val * n
  end

  def sigs(arr)
    return arr.map { |el| sig_strength(el) }
  end

  def print?(n)
    if n == 10
      puts "#{10}:::: #{@x[9]}"
    end
    val = @x[n-1]
    if val.nil?
      puts "got nil print?(#{n})"
      return false
    end
    n = n % 40
    if n == 0
      n = 40
    end
    n -= 1
    if n == val - 1 || n == val || n == val + 1
      return true
    end
    return false
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
