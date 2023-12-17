require "2023day_17"

RSpec.describe Solution17 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_17_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_17.txt"
  end

  it "gets the grid" do
    sol = Solution17.new(@test_case)
    expect(sol.getGrid.read(1, 1)).to eq "2"
    expect(sol.getGrid.read(1, 3)).to eq "5"
  end

  it "takes a step" do
    sol = Solution17.new(@test_case)
    expect(sol.takeStep([5, 6], [1, 0])).to eq [6, 6]
    expect(sol.takeStep([5, 6], [0, -1])).to eq [5, 5]
  end

  # it "calcs valid steps" do
  #   sol = Solution17.new(@test_case)
  #   expect(sol.validSteps("LLL")).to eq ["U", "D"]
  #   expect(sol.validSteps("RRR")).to eq ["U", "D"]
  #   expect(sol.validSteps("UUU")).to eq ["L", "R"]
  #   expect(sol.validSteps("DDD")).to eq ["L", "R"]
  #   expect(sol.validSteps("LLD")).to eq ["L", "R", "D"]
  #   expect(sol.validSteps("LLU")).to eq ["L", "R", "U"]
  #   expect(sol.validSteps("LUR")).to eq ["U", "D", "R"]
  #   expect(sol.validSteps("LUL")).to eq ["U", "D", "L"]
  # end

  it "solves example test case (part 1)" do
    sol = Solution17.new(@test_case)
    expect(sol.run(1, 3)).to eq 102
  end

  it "solves example test case (part 2)" do
    sol = Solution17.new(@test_case)
    expect(sol.run_2).to eq 94
  end

  it "solves big test (part 1)" do
    sol = Solution17.new(@big_test)
    expect(sol.run(1, 3)).to eq 1138
    # 1089 is too low
    # 1135 is too low
    # 1154 is too high
  end

  it "solves big test (part 2)" do
    sol = Solution17.new(@big_test)
    expect(sol.run_2).to eq 1312
  end
end
