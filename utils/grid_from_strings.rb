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
    @grid = []
    out.each {|row| @grid << row}
    return out
  end

  def self.add(a, b)
    out = []
    a.rows.times do |r|
        out << a.grid[r].join("") + b.grid[r].join("")
    end
    return out
  end
end
