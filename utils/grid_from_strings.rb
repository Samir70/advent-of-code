class GridFromStrings
  def initialize(str_arr)
    @grid = []
    @rows = str_arr.length
    @cols = str_arr[0].length
    str_arr.each do |str|
      @grid << str.split("")
    end
  end

  attr_reader :grid, :rows, :cols

  def read (r, c)
    return nil if @grid[r] == nil
    return @grid[r][c]
  end

  def rotate
    out = []
    # want a row for every column
    for c in 0...@cols do
        out << @grid.map {|row| row[@cols - 1 - c]}
    end
    out.map! {|r| r.join("")}
    return GridFromStrings.new(out)
  end

  def self.add(*grids)
    out = []
    grids[0].rows.times do |r|
        row = ""
        grids.each { |g| row += g.grid[r].join("")}
        out << row
    end
    return out
  end

  def to_s
    @grid.each do |row|
        puts row.join("")
    end
  end
end
