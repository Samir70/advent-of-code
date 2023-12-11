require "2023day_11"

RSpec.describe Solution11 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_11_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_11.txt"
  end

  it "loads the grid" do
    sol = Solution11.new(@test_case)
    expect(sol.getGrid.read(0, 3)).to eq "#"
  end

  it "it counts galaxies in cols and rows" do
    sol = Solution11.new(@test_case)
    expect(sol.countGals(sol.getGrid.getCol(3))).to eq 1
    expect(sol.countGals(sol.getGrid.getCol(2))).to eq 0
  end

  it "finds empty cols" do
    sol = Solution11.new(@test_case)
    expect(sol.emptyCols(sol.getGrid)).to eq [8, 5, 2]
  end
  it "finds empty rows" do
    sol = Solution11.new(@test_case)
    expect(sol.emptyRows(sol.getGrid)).to eq [7, 3]
  end

  # it "expands universe" do
  #   sol = Solution11.new(@test_case)
  #   expect(sol.getExpanded.read(0, 4)).to eq "#"
  #   expect(sol.getExpanded.cols).to eq 13
  #   expect(sol.getExpanded.rows).to eq 12
  # end

  it "finds galazies" do
    sol = Solution11.new(@test_case)
    expect(sol.findGals.length).to eq 9
    expect(sol.findGals).to eq [[0, 3], [1, 7], [2, 0], [4, 6], [5, 1], [6, 9], [8, 7], [9, 0], [9, 4]]
  end

  it "finds dist between two gals" do
    sol = Solution11.new(@test_case)
    expect(sol.dist([0, 3], [1, 7], [7, 3], [8, 5, 2], 1)).to eq 6
    expect(sol.dist([0, 3], [2, 0], [7, 3], [8, 5, 2], 1)).to eq 6
    expect(sol.dist([5, 1], [9, 4], [7, 3], [8, 5, 2], 1)).to eq 9
  end

  it "solves example test case (part 1)" do
    sol = Solution11.new(@test_case)
    expect(sol.run(2)).to eq 374
  end

  it "gets factor 10 and 100 correct" do
    sol = Solution11.new(@test_case)
    expect(sol.run(10)).to eq 1030
    expect(sol.run(100)).to eq 8410
  end

  it "solves example test case (part 2)" do
    sol = Solution11.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it "solves big test (part 1)" do
    sol = Solution11.new(@big_test)
    expect(sol.run(2)).to eq 9556712
  end

  it "solves big test (part 2)" do
    sol = Solution11.new(@big_test)
    expect(sol.run(1000000)).to eq 678626199476
  end
end
