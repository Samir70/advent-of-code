require "2023day_10"

RSpec.describe Solution10 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_10_1.txt"
    @test_case2 = "./lib/inputs/test_cases/2023day_10_2.txt"
    @test_case3 = "./lib/inputs/test_cases/2023day_10_3.txt"
    @big_test = "./lib/inputs/big_tests/2023day_10.txt"
  end

  it "stores the grid" do
    sol = Solution10.new(@test_case)
    expect(sol.getGrid.read(0, 0)).to eq "7"
  end

  it "extracts a column" do
    sol = Solution10.new(@test_case)
    expect(sol.getGrid.getCol(1)).to eq "-FJFJ"
  end

  it "finds Start" do
    sol = Solution10.new(@test_case)
    expect(sol.findStart(sol.getGrid)).to eq [2, 0]
  end

  it "finds reverse direction" do
    sol = Solution10.new(@test_case)
    expect(sol.reverseDir(*[1, 0])).to eq [-1, 0]
    expect(sol.reverseDir(*[-1, 0])).to eq [1, 0]
    expect(sol.reverseDir(*[0, 1])).to eq [0, -1]
    expect(sol.reverseDir(*[0, -1])).to eq [0, 1]
  end

  it "finds left of direction" do
    sol = Solution10.new(@test_case)
    expect(sol.leftOf([1, 0])).to eq [0, 1]
    expect(sol.leftOf([-1, 0])).to eq [0, -1]
    expect(sol.leftOf([0, 1])).to eq [-1, 0]
    expect(sol.leftOf([0, -1])).to eq [1, 0]
  end

  it "takes a step" do
    sol = Solution10.new(@test_case)
    expect(sol.takeStep([5, 6], [1, 0])).to eq [6, 6]
    expect(sol.takeStep([5, 6], [0, -1])).to eq [5, 5]
  end

  it "judges if move was legal" do
    sol = Solution10.new(@test_case)
    expect(sol.isLegal([1, 0], [[-1, 0], [1, 0]])).to eq true
    expect(sol.isLegal([1, 0], [[0, 1], [1, 0]])).to eq false
  end

  it "counts steps to get back to S" do
    sol = Solution10.new(@test_case)
    expect(sol.traverse(sol.getGrid, [2, 0], [-1, 0], nil)).to eq nil
    expect(sol.traverse(sol.getGrid, [2, 0], [0, -1], nil)).to eq nil
    expect(sol.traverse(sol.getGrid, [2, 0], [1, 0], nil)[:count]).to eq 16
    expect(sol.traverse(sol.getGrid, [2, 0], [0, 1], nil)[:count]).to eq 16
  end

  it "solves example test case (part 1)" do
    sol = Solution10.new(@test_case)
    expect(sol.run).to eq 8
  end

  it "counts verts and horizontals" do
    sol = Solution10.new(@test_case2)
    expect(sol.countVerts(".|..||..|.", 2)).to eq [1, 3]
    expect(sol.countHors(".-F||L.-.", 6)).to eq [3, 1]
  end

  # it "judges if point is bounded" do
  #   sol = Solution10.new(@test_case2)
  #   grid = sol.getMap([1, 0])[:grid]
  #   expect(sol.isBounded?(grid, 6, 2)).to eq true
  #   expect(sol.isBounded?(grid, 4, 3)).to eq false
  #   expect(sol.isBounded?(grid, 4, 4)).to eq false
  # end

  it "solves example test case (part 2)" do
    sol2 = Solution10.new(@test_case2)
    sol3 = Solution10.new(@test_case3)
    expect(sol2.findStart(sol2.getGrid)).to eq [1, 1]
    expect(sol3.findStart(sol3.getGrid)).to eq [0, 4]
    expect(sol2.traverse(sol2.getGrid, [1, 1], [-1, 0], nil)).to eq nil
    expect(sol2.traverse(sol2.getGrid, [1, 1], [0, -1], nil)).to eq nil
    expect(sol2.traverse(sol2.getGrid, [1, 1], [1, 0], nil)[:count]).to eq 44
    expect(sol2.traverse(sol2.getGrid, [1, 1], [0, 1], nil)[:count]).to eq 44
    expect(sol3.traverse(sol3.getGrid, [0, 4], [-1, 0], nil)).to eq nil
    expect(sol3.traverse(sol3.getGrid, [0, 4], [0, -1], nil)[:count]).to eq 160
    expect(sol3.traverse(sol3.getGrid, [0, 4], [1, 0], nil)[:count]).to eq 160
    expect(sol3.traverse(sol3.getGrid, [0, 4], [0, 1], nil)).to eq nil
    # expect(sol2.run_2([1, 0])).to eq 4
    expect(sol3.run_2([0, -1])).to eq 10
  end

  it "solves big test (part 1)" do
    sol = Solution10.new(@big_test)
    expect(sol.run).to eq 7102
    # 7100 and 7101 are too low
  end

  it "solves big test (part 2)" do
    sol = Solution10.new(@big_test)
    expect(sol.run_2([0, 1])).to eq 363
    # 5028 is too high
    # 357 is too small
    # 400 is too high
    # tried 375
  end
end
