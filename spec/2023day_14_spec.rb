require "2023day_14"

RSpec.describe Solution14 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_14_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_14.txt"
  end

  it "loads grid" do
    sol = Solution14.new(@test_case)
    expect(sol.getGrid.read(0, 0)).to eq "O"
  end

  it "tilts a string" do
    sol = Solution14.new(@test_case)
    expect(sol.tilt("OO.O.O..##")).to eq "OOOO....##"
    expect(sol.tilt(".O...#O..O")).to eq "O....#OO.."
    expect(sol.tilt("...OO....O")).to eq "OOO......."
  end

  it "tilts north" do
    sol = Solution14.new(@test_case)
    expect(sol.tiltNorth(sol.getGrid).getCol(0)).to eq "OOOO....##"
    expect(sol.tiltNorth(sol.getGrid).getCol(5)).to eq "#.#O..#.##"
  end
  it "tilts south" do
    sol = Solution14.new(@test_case)
    expect(sol.tiltSouth(sol.getGrid).getCol(0)).to eq "....OOOO##"
    expect(sol.tiltSouth(sol.getGrid).getCol(5)).to eq "#.#..O#.##"
  end
  it "tilts East" do
    sol = Solution14.new(@test_case)
    expect(sol.tiltEast(sol.getGrid).getRow(1)).to eq ".OOO#....#"
    expect(sol.tiltEast(sol.getGrid).getRow(7)).to eq ".........O"
  end
  it "tilts West" do
    sol = Solution14.new(@test_case)
    expect(sol.tiltWest(sol.getGrid).getRow(1)).to eq "OOO.#....#"
    expect(sol.tiltWest(sol.getGrid).getRow(7)).to eq "O........."
  end
  it "calcs a load" do
    sol = Solution14.new(@test_case)
    grid = sol.tiltNorth(sol.getGrid)
    expect(sol.calcLoad(grid)).to eq 136
  end

  it "completes a cycle" do
    sol = Solution14.new(@test_case)
    expect(sol.cycle(sol.getGrid).getRow(7)).to eq "......OOOO"
  end

  it "values a string" do
    sol = Solution14.new(@test_case)
    expect(sol.value("OOOO....##")).to eq 34
  end

  it "solves example test case (part 1)" do
    sol = Solution14.new(@test_case)
    expect(sol.run).to eq 136
  end

  # it "solves example test case (part 2)" do
  #   sol = Solution14.new(@test_case)
  #   expect(sol.run_2).to eq 64
  # end

  it "solves big test (part 1)" do
    sol = Solution14.new(@big_test)
    expect(sol.run).to eq 106648
  end

  it "solves big test (part 2)" do
    sol = Solution14.new(@big_test)
    expect(sol.run_2).to eq 87700
    # 87666 is too low
    # 87683 is too low
  end
end
