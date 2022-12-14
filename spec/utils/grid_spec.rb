require_relative "../../utils/grid_from_points"

RSpec.describe GridFromPoints do
  before(:each) do
    points = [
      [0, 2], [5, 7], [-3, 2], [4, -2],
    ]
    @grid = GridFromPoints.new(points, ".", "index")
  end
  context "finding size of grid" do
    it "finds the min row value of the points" do
      expect(@grid.min_row).to eq -3
    end
    it "finds the max row value of the points" do
      expect(@grid.max_row).to eq 5
    end
    it "finds the min column value of the points" do
      expect(@grid.min_col).to eq -2
    end
    it "finds the max column value of the points" do
      expect(@grid.max_col).to eq 7
    end
    it "finds the width of the grid" do
      expect(@grid.width).to eq 10
    end
    it "finds the height of the grid" do
      expect(@grid.height).to eq 9
    end
  end
  it "shifts all points to non-neg" do
    expect(@grid.points).to eq [[3, 4], [8, 9], [0, 4], [7, 0]]
  end
  it "makes a grid" do
    expect(@grid.grid).to eq [
                               [".", ".", ".", ".", 2, ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", 0, ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [3, ".", ".", ".", ".", ".", ".", ".", ".", "."],
                               [".", ".", ".", ".", ".", ".", ".", ".", ".", 1],
                             ]
  end
  it "changes a point in the grid" do
    expect(@grid.change_point(2, 3, 4)).to eq true
    expect(@grid.grid[2][3]).to eq 4
  end
  it "reports co-ordinates are out-of-bounds if trying to change point off grid" do
    expect(@grid.change_point(200, 3, 4)).to eq false
    expect(@grid.change_point(-2, 3, 4)).to eq false
    expect(@grid.change_point(2, -3, 4)).to eq false
    expect(@grid.change_point(2, 300, 4)).to eq false
  end
end
