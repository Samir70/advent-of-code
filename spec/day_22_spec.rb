require "day_22"

RSpec.describe Solution22 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_22_1.txt"
    @big_test = "./lib/inputs/big_tests/day_22.txt"
  end

  it "splits instructions into numbers/L/R" do
    expect(split_instructions("10R5L5R10L4R5L5")).to eq [10, "R", 5, "L", 5, "R", 10, "L", 4, "R", 5, "L", 5]
  end

  it "tracks direction" do
    d = Direction.new()
    expect(d.dir).to eq 0
    expect(d.vector).to eq [0, 1]
    d.change("R")
    expect(d.dir).to eq 1
    expect(d.vector).to eq [1, 0]
    d.change("R")
    expect(d.vector).to eq [0, -1]
    d.change("R")
    expect(d.vector).to eq [-1, 0]
    d.change("R")
    expect(d.dir).to eq 0
    expect(d.vector).to eq [0, 1]
    d.change("L")
    expect(d.vector).to eq [-1, 0]
    d.change("L")
    expect(d.vector).to eq [0, -1]
    d.change("L")
    expect(d.vector).to eq [1, 0]
    d.change("L")
    expect(d.vector).to eq [0, 1]
  end

  it "extracts the points from data" do
    sol = Solution22.new(@test_case)
    expect(sol.loc).to eq [1, 9]
    expect(sol.points.first).to eq [1, 9, "."]
    expect(sol.points).to_not include [1, 8, " "]
    expect(sol.points).to include [1, 12, "#"]
    expect(sol.points).to include [12, 15, "#"]
    expect(sol.points.last).to eq [12, 16, "."]
  end

  it "loads the map and instrucitons" do
    sol = Solution22.new(@test_case)
    expect(sol.instructions).to eq [10, "R", 5, "L", 5, "R", 10, "L", 4, "R", 5, "L", 5]
    expect(sol.grid.read(6, 9)).to eq "#"
    expect(sol.grid.read(5, 12)).to eq "#"
    expect(sol.grid.read(4, 8)).to eq nil
    puts sol.grid
  end

  it "can step right in the grid" do
    sol = Solution22.new(@test_case)
    expect(sol.grid.step_right(4, 9)).to eq [4, 10]
    expect(sol.grid.step_right(5, 11)).to eq [5, 11]
    expect(sol.grid.step_right(3, 12)).to eq [3, 12]
    expect(sol.grid.step_right(6, 12)).to eq [6, 1]
    expect(sol.grid.step_right(11, 16)).to eq [11, 9]
  end
  it "can step left in the grid" do
    sol = Solution22.new(@test_case)
    expect(sol.grid.step_left(5, 5)).to eq [5, 5]
    expect(sol.grid.step_left(10, 12)).to eq [10, 11]
    expect(sol.grid.step_left(4, 9)).to eq [4, 12]
    expect(sol.grid.step_left(1, 9)).to eq [1, 9]
    expect(sol.grid.step_left(11, 9)).to eq [11, 16]
  end
  it "can step down in the grid" do
    sol = Solution22.new(@test_case)
    expect(sol.grid.step_down(4, 9)).to eq [5, 9]
    expect(sol.grid.step_down(5, 9)).to eq [5, 9]
    expect(sol.grid.step_down(8, 8)).to eq [5, 8]
    expect(sol.grid.step_down(12, 12)).to eq [12, 12]
    expect(sol.grid.step_down(12, 9)).to eq [1, 9]
  end
  it "can step up in the grid" do
    sol = Solution22.new(@test_case)
    expect(sol.grid.step_up(4, 9)).to eq [4, 9]
    expect(sol.grid.step_up(5, 9)).to eq [4, 9]
    expect(sol.grid.step_up(5, 8)).to eq [8, 8]
    expect(sol.grid.step_up(9, 15)).to eq [9, 15]
    expect(sol.grid.step_up(9, 16)).to eq [12, 16]
  end

  it "adds teleport co-ordinates for edges of net" do
    
  end

  it "solves example test case (part 1)" do
    sol = Solution22.new(@test_case)
    expect(sol.run).to eq 6032
  end
  it "solves big test (part 1)" do
    sol = Solution22.new(@big_test)
    expect(sol.run).to eq 31568
  end

  it "solves example test case (part 2)" do
    sol = Solution22.new(@test_case)
    expect(sol.run_2).to eq 5031
  end

  it "solves big test (part 2)" do
    sol = Solution22.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
