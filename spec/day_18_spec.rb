require "day_18"

RSpec.describe Solution18 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_18_1.txt"
    @big_test = "./lib/inputs/big_tests/day_18.txt"
  end

  it "parses input to get an array of Point3D" do
    sol = Solution18.new(@test_case)
    p1 = Point3D.new(2, 2, 2)
    p2 = Point3D.new(2, 3, 5)
    expect(sol.data.first).to eq p1
    expect(sol.data.last).to eq p2
    expect(sol.data.length).to eq 13
  end

  it "can check if points are in grid" do
    sol = Solution18.new(@test_case)
    expect(sol.grid.check(2, 2, 2)).to eq true
    expect(sol.grid.check(2, 3, 5)).to eq true
    expect(sol.grid.check(4, 1, 2)).to eq "no point with x = 4"
    expect(sol.grid.check(-1, 1, 2)).to eq "no point with x = -1"
    expect(sol.grid.check(1, 1, 2)).to eq "no point with x = 1, y = 1"
    expect(sol.grid.check(2, 3, 4)).to eq "no point with x = 2, y = 3, z = 4"
  end

  it "can check if a point is interior to shape of grid" do
    sol = Solution18.new(@test_case)
    expect(sol.grid.is_interior?(2, 2, 2)).to eq "is part of shape"
    expect(sol.grid.is_interior?(2, 2, 5)).to eq true
    expect(sol.grid.is_interior?(3, 3, 2)).to eq false
  end

  it "finds neighbours of a point" do
    p1 = Point3D.new(0, 2, 2)
    expect(p1.neighbours).to eq [[-1, 2, 2], [1, 2, 2], [0, 1, 2], [0, 3, 2], [0, 2, 1], [0, 2, 3]]
  end

  it "solves example test case (part 1)" do
    sol = Solution18.new(@test_case)
    expect(sol.run).to eq 64
  end
  it "solves big test (part 1)" do
    sol = Solution18.new(@big_test)
    expect(sol.run).to eq 3374
  end

  it "solves example test case (part 2)" do
    sol = Solution18.new(@test_case)
    sol2 = Solution18.new(sol.run_2)
    expect(64 - sol2.run).to eq 58
  end
  it "solves big test (part 2)" do
    sol = Solution18.new(@big_test)
    interiors = sol.run_2
    sol2 = Solution18.new(interiors)
    # finds 1040 interior points
    puts "#{interiors.length}"
    expect(3374 - sol2.run).to eq 2010
    # 1998 is too low
  end
end
