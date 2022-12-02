class Elf
  def initialize
    @carrying = []
    @sum = 0
  end

  def add(n)
    @carrying << n
    @sum += n
  end

  def to_s
    return "Carrying #{@carrying[0..4]}, total: #{@sum}"
  end

  attr_reader :sum, :carrying
end

class CountCals
  def initialize(file_name)
    @file_name = file_name
    @elves = []
    @best = 0
    @sum = 0
    @elf = Elf.new
    process
  end

  def run
    return @best
  end

  def run_2
    return @elves.sort_by { |elf| elf.sum }[-3..-1].map { |elf| elf.sum }.sum
  end

  def process
    file = File.new(@file_name)
    file_data = file.readlines.map(&:to_i)
    file_data.each do |line|
      if line == 0
        @elves << @elf
        @elf = Elf.new
        # puts "This elf is carrying #{@sum}, best is #{@best}"
        if @sum >= @best
          @best = @sum
        end
        @sum = 0
      else
        @elf.add(line)
        @sum += line
      end
    end
    @elves << @elf
    # puts "The Last elf is carrying #{@sum}, best is #{@best}"
    if @sum > @best
      @best = @sum
    end
    file.close
  end
end
