class GridFromPoints
  def initialize(points, blank_char, fill_char)
    @blank_char = blank_char
    @fill_char = fill_char
    @min_row = points.map { |p| p[0] }.min
    @min_col = points.map { |p| p[1] }.min
    @max_row = points.map { |p| p[0] }.max
    @max_col = points.map { |p| p[1] }.max
    @width = 1 + @max_col - @min_col
    @height = 1 + @max_row - @min_row
    @points = points.map { |p| [p[0] - @min_row, p[1] - @min_col] }
    @grid = []
    make_grid
    put_points_on_grid
  end

  def to_s
    @grid.each do |row|
      puts row.join("") #"#{row}"
    end
  end

  def make_grid
    @height.times do
      row = Array.new(@width, @blank_char)
      @grid << row
    end
  end

  def put_points_on_grid
    @points.each_with_index do |p, i|
      r, c = p
      # puts "point #{p}, with index #{i} give #{r}, #{c}"
      @grid[r][c] = (@fill_char == "index" ? i : @fill_char)
    end
  end

  def change_point(r, c, val)
    # co-ordinates are in the new system after recalibration
    if r < 0 || r >= @height || c < 0 || c >= @width
      return false
    end
    @grid[r][c] = val
    return true
  end

  def add_row(val)
    @height += 1
    @grid << Array.new(@width, val)
  end
  attr_reader :min_row, :min_col, :max_col, :max_row, :width, :height, :points, :grid
end
