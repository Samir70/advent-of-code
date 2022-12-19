require "day_19"

RSpec.describe Solution19 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_19_1.txt"
    @big_test = "./lib/inputs/big_tests/day_19.txt"
  end

  it "adds vectors" do
    a = [1, 2, 3, 4]
    b = [2, 3, 4, 5]
    c = [0, 3, 5, 6]
    expect(add_vector(a, b)).to eq [3, 5, 7, 9]
    expect(add_vector(a, c)).to eq [1, 5, 8, 10]
    expect(add_vector(b, c)).to eq [2, 6, 9, 11]
  end
  it "parses a blueprint" do
    sol = Solution19.new(@test_case)
    bp_str = "Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian."
    bp = BluePrint.new([[4, 0, 0], [2, 0, 0], [3, 14, 0], [2, 0, 7]])
    # expect(bp.robots).to eq [1, 0, 0, 0]
    # expect(bp.materials).to eq [0, 0, 0, 0]
    expect(sol.parseBP(bp_str).ore).to eq [4, 0, 0]
    expect(sol.parseBP(bp_str).clay).to eq [2, 0, 0]
    expect(sol.parseBP(bp_str).obsidian).to eq [3, 14, 0]
    expect(sol.parseBP(bp_str).geode).to eq [2, 0, 7]
  end

  # it "determines materials collected if robots made in given order" do
  #   sol = Solution19.new(@test_case)
  #   bp_str = "Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian."
  #   bp = BluePrint.new([[4, 0, 0], [2, 0, 0], [3, 14, 0], [2, 0, 7]])
  #   bp.make_robots([0, 0, 0], 24)
  #   expect(bp.robots).to eq [4, 0, 0, 0]
  #   expect(bp.materials).to eq [61, 0, 0, 0]
  #   bp = BluePrint.new([[4, 0, 0], [2, 0, 0], [3, 14, 0], [2, 0, 7]])
  #   bp.make_robots([1, 1, 1, 2, 1, 2, 3, 3], 24)
  #   expect(bp.robots).to eq [1, 4, 2, 2]
  #   expect(bp.materials).to eq [6, 41, 8, 9]
  # end

  # it "lists possible orders of making robots" do
  #   expect(make_orders("1", 1)).to eq ["1"]
  #   expect(make_orders("1", 2)).to eq ["10", "11", "12"]
  #   expect(make_orders("1", 3)).to eq ["100", "101", "102", "110", "111", "112", "120", "121", "122", "123"]
  #   # puts make_orders("0", 10).length
  # end

  it "solves example test case (part 1)" do
    sol = Solution19.new(@test_case)
    expect(sol.run(24)).to eq 33
  end

  it "solves example test case (part 2)" do
    sol = Solution19.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it "solves big test (part 1)" do
    sol = Solution19.new(@big_test)
    expect(sol.run(24)).to eq 1616
    # 1596 is too low
  end

  it "solves big test (part 2)" do
    sol = Solution19.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
