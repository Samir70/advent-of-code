class Solution05
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @piles = []
    @instructions = []
    process
  end

  def run(crane_type)
    @instructions.each do |ins|
      todo = get_detail_todo(ins)
      move_crates(todo, crane_type)
    end
    return give_tops
  end

  def give_tops
    return @piles.map { |p| p[0]}.join("")
  end

  def get_detail_todo(instruction)
    words = instruction.split(" ")
    return [words[1], words[3], words[5]].map(&:to_i)
  end

  def move_crates(arr, crane_type)
    num_crates, from, dest = arr
    from -= 1
    dest -= 1
    moving = @piles[from][0, num_crates]
    if crane_type == 9000
      moving.reverse!
    end
    leaving = @piles[from][num_crates, 100000]
    # puts "moving: #{moving} from #{from} to #{dest}"
    @piles[dest] = moving.concat(@piles[dest])
    @piles[from] = leaving
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close

    stacks = (@data[0].length / 4.0).ceil
    stacks.times do
      @piles << []
    end

    i = 0
    while i < @data.length && @data[i][1] != "1"
      # puts @data[i], @data[i].length
      j = 1
      stack = 0
      while j < @data[i].length
        # puts "#{j} stack #{stack} == '#{@data[i][j]}'"
        if @data[i][j] != " "
          @piles[stack] << @data[i][j]
        end
        j += 4
        stack += 1
      end
      # puts "#{@piles}"
      i += 1
    end
    i += 2
    while i < @data.length
      @instructions << @data[i]
      i += 1
    end
  end

  attr_reader :piles, :instructions
end
