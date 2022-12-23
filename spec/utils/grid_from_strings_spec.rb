require_relative "../../utils/grid_from_strings"

RSpec.describe GridFromStrings do
  it "reads by row, col" do
    g = GridFromStrings.new(["...#", ".#..", "#...", "...."])
    expect(g.read(0, 3)).to eq "#"
    expect(g.read(3, 3)).to eq "."
    expect(g.read(4, 3)).to eq nil
    expect(g.read(3, 13)).to eq nil
  end

  it "rotates the grid" do
    g = GridFromStrings.new(["...#", ".#..", "#...", "...."])
    g.rotate
    expect(g.grid.first.join("")).to eq "#..."
    expect(g.grid[1].join("")).to eq "...."
    expect(g.grid[2].join("")).to eq ".#.."
    expect(g.grid.last.join("")).to eq "..#."
  end
end
