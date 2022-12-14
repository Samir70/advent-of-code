require "day_14"

RSpec.describe Solution14 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_14_1.txt"
    @big_test = "./lib/inputs/big_tests/day_14.txt"
  end

  it "extracts points from 10,3 -> 10,6 -> 8,6" do
    sol = Solution14.new(@test_case)
    expect(sol.extract_points("10,3 -> 10,6 -> 8,6")).to eq [[3, 10], [6, 10], [6, 8]]
  end
  it "makes lines from 10,3 -> 10,6" do
    sol = Solution14.new(@test_case)
    expect(sol.make_lines("10,3 -> 10,6")).to eq Set.new([[3, 10], [4, 10], [5, 10], [6, 10]])
  end
  it "makes lines from 10,6 -> 10,3" do
    sol = Solution14.new(@test_case)
    expect(sol.make_lines("10,6 -> 10,3")).to eq Set.new([[3, 10], [4, 10], [5, 10], [6, 10]])
  end
  it "makes lines from 10,6 -> 13,6" do
    sol = Solution14.new(@test_case)
    expect(sol.make_lines("10,6 -> 13,6")).to eq Set.new([[6, 10], [6, 11], [6, 12], [6, 13]])
  end
  it "makes lines from 13,6 -> 10,6" do
    sol = Solution14.new(@test_case)
    expect(sol.make_lines("13,6 -> 10,6")).to eq Set.new([[6, 10], [6, 11], [6, 12], [6, 13]])
  end
  it "reports diagonal when trying to make lines from 10,3 -> 13,6" do
    sol = Solution14.new(@test_case)
    expect(sol.make_lines("10,3 -> 13,6")).to eq "neither row nor column match [3, 10] -> [6, 13]"
  end
  it "makes a grid" do
    sol = Solution14.new(@test_case)
    sol.make_grid
    expect(sol.grid.min_row).to eq 0
    expect(sol.grid.min_col).to eq 494
    expect(sol.entry).to eq [0, 6]
    expect(sol.grid.grid).to eq [
         "......+...".split(""),
         "..........".split(""),
         "..........".split(""),
         "..........".split(""),
         "....#...##".split(""),
         "....#...#.".split(""),
         "..###...#.".split(""),
         "........#.".split(""),
         "........#.".split(""),
         "#########.".split("")
       ]
  end

  it "detects when sand is settled" do
    sol = Solution14.new(@test_case)
    expect(sol.settled?("#", "#", "#")).to eq true
    expect(sol.settled?(".", "#", "#")).to eq false
    expect(sol.settled?("#", ".", "#")).to eq false
    expect(sol.settled?("#", "#", ".")).to eq false
    expect(sol.settled?(nil, "#", ".")).to eq false
  end

  it "drops sand" do
    sol = Solution14.new(@test_case)
    sol.make_grid
    expect(sol.drop_sand).to eq [8, 6]
    expect(sol.grid.grid[8][6]).to eq "o"
  end
  it "drops many grains of sand" do
    sol = Solution14.new(@test_case)
    sol.make_grid
    expect(sol.drop_sand).to eq [8, 6]
    expect(sol.grid.grid[8][6]).to eq "o"
    expect(sol.drop_sand).to eq [8, 5]
    expect(sol.grid.grid[8][5]).to eq "o"
    expect(sol.drop_sand).to eq [8, 7]
    expect(sol.grid.grid[8][7]).to eq "o"
    expect(sol.drop_sand).to eq [7, 6]
    expect(sol.grid.grid[7][6]).to eq "o"
  end

  it "solves example test case (part 1)" do
    sol = Solution14.new(@test_case)
    expect(sol.run).to eq 24
  end

  it "solves example test case (part 2)" do
    sol = Solution14.new(@test_case)
    expect(sol.run_2).to eq 93
  end

  it "solves big test (part 1)" do
    sol = Solution14.new(@big_test)
    expect(sol.run).to eq 1199
  end

  it "solves big test (part 2)" do
    sol = Solution14.new(@big_test)
    expect(sol.run_2).to eq 23925
  end
end
