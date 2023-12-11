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

  def read(r, c)
    return nil if @grid[r] == nil
    return @grid[r][c]
  end

  def set(r, c, val)
    return nil if @grid[r] == nil
    @grid[r][c] = val
    return true
  end

  def keepOnly(char)
    @rows.times do |r|
      @cols.times do |c|
        set(r, c, ".") if read(r, c) != char
      end
    end
  end

  def rotate
    out = []
    # want a row for every column
    for c in 0...@cols
      out << @grid.map { |row| row[@cols - 1 - c] }
    end
    out.map! { |r| r.join("") }
    return GridFromStrings.new(out)
  end

  def getCol(c)
    return @grid.map { |r| r[c] }.join("")
  end

  def getRow(r)
    return @grid[r].join("")
  end

  def addCol(c)
    return nil if c >= @cols
    @grid.each do |row|
      row.insert(c, ".")
    end
    @cols += 1
  end

  def addRow(r)
    return nil if r >= @rows
    @grid.insert(r, ("." * @cols).split(""))
    @rows += 1
  end

  def self.add(*grids)
    out = []
    grids[0].rows.times do |r|
      row = ""
      grids.each { |g| row += g.grid[r].join("") }
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
