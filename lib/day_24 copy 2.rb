class Solution24
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @target = []
    @max_r = 0
    @max_c = 0
    @target = []
    @storms = []
    process
  end

  attr_reader :storms, :max_r, :max_c

  def run
  
  end

  def run_2
  
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    @max_r = @data.length - 2
    @max_c = @data.first.length - 2
    @target = [@max_r + 1, @max_c]
    for r in 1..@max_r do
      for c in 1..@max_c do
        puts "#{[r, c]} == #{@data[r][c]}"
        @storms << Storm.new(@data[r][c], r, c, @max_r, @max_c) if @data[r][c] != "."
      end
    end
  end
end

class Storm
  def initialize(type, r, c, max_r, max_c)
    @type = type
    @r = r
    @c = c
    @max_r = max_r
    @max_c = max_c
  end

  def loc
    return [@r, @c]
  end

  def move
    case @type
    when ">"
      @c += 1
      @c = 1 if @c > @max_c
    when "<"
      @c -= 1
      @c = @max_c if @c < 1
    when "^"
      @r -= 1
      @r = @max_r if @r < 1
    when "v"
      @r += 1
      @r = 1 if @r > @max_r
    end
  end

end