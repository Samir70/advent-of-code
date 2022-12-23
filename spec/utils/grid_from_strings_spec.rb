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
    new_g = g.rotate
    expect(new_g.grid[0].join("")).to eq "#..."
    expect(new_g.grid[1].join("")).to eq "...."
    expect(new_g.grid[2].join("")).to eq ".#.."
    expect(new_g.grid[3].join("")).to eq "..#."
  end

  it "can add two grids together" do
    g1 = GridFromStrings.new(["...#", ".#..", "#...", "...."])
    g2 = GridFromStrings.new(["...#", ".#..", "#...", "####"])
    res = GridFromStrings.add(g1, g2)
    expect(res).to eq ["...#...#", ".#...#..", "#...#...", "....####"]
  end
end
