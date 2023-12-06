require "2023day_06"

RSpec.describe Solution06 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_06_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_06.txt"
  end

  it "parses times and distances for each race" do
    sol = Solution06.new(@test_case)
    expect(sol.getRaces.first).to eq [7, 9]
    expect(sol.getRaces.last).to eq [30, 200]
  end

  it "calcs min hold for a race" do
    sol = Solution06.new(@test_case)
    expect(sol.calcMinHold(7, 9)).to eq 2
  end

  it "counts the ways to win" do
    sol = Solution06.new(@test_case)
    expect(sol.ways2win(7, 9)).to eq 4
    expect(sol.ways2win(15, 40)).to eq 8
    expect(sol.ways2win(30, 200)).to eq 9
  end

  it "gets big race" do
    sol = Solution06.new(@test_case)
    expect(sol.bigrace).to eq [71530, 940200]
  end

  it "solves example test case (part 1)" do
    sol = Solution06.new(@test_case)
    expect(sol.run).to eq 288
  end

  it "solves example test case (part 2)" do
    sol = Solution06.new(@test_case)
    expect(sol.run_2).to eq 71503
  end

  it "solves big test (part 1)" do
    sol = Solution06.new(@big_test)
    expect(sol.run).to eq 138915
    # 27783 is too low
  end

  it "solves big test (part 2)" do
    sol = Solution06.new(@big_test)
    expect(sol.run_2).to eq 27340847
  end
end
