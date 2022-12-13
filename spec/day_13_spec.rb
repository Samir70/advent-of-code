require "day_13"

RSpec.describe Solution13 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_13_1.txt"
    @big_test = "./lib/inputs/big_tests/day_13.txt"
  end

  # it "splits data into pairs" do
  #   sol = Solution13.new(@test_case)
  #   expect(sol.data[0]).to eq [[1, 1, 3, 1, 1], [1, 1, 5, 1, 1]]
  # end

  it "compares arr of int" do
    sol = Solution13.new(@test_case)
    expect(sol.compare([1, 1, 3, 1, 1], [1, 1, 5, 1, 1])).to eq true
    expect(sol.compare([1, 4, 3, 1, 1], [1, 1, 5, 1, 1])).to eq false
    expect(sol.compare([1, 1, 3, 1, 1], [1, 1, 3, 1])).to eq false
    expect(sol.compare([1, 1, 3, 1], [1, 1, 3, 1, 1])).to eq true
  end

  it "Compare [[1],[2,3,4]] vs [[1],4]" do
    sol = Solution13.new(@test_case)
    expect(sol.compare([[1], [2, 3, 4]], [[1], 4])).to eq true
    expect(sol.compare([[1], 4], [[1], [2, 3, 4]])).to eq false
  end
  # it "Compares all pairs" do
  #   sol = Solution13.new(@test_case)
  #   expect(sol.compare_all).to eq [true, true, false, true, false, true, false, false]
  # end

  it "compares [[4, [4], [[10, 7, 2], [1, 6, 5, 7, 4], [7, 3, 3, 1, 5], []], 1], [[], [[7, 6, 3]], 5, 5]]
  [[[10]]]" do
    sol = Solution13.new(@test_case)
    expect(sol.compare([[4, [4], [[10, 7, 2], [1, 6, 5, 7, 4], [7, 3, 3, 1, 5], []], 1], [[], [[7, 6, 3]], 5, 5]],
    [[[10]]])).to eq true
  end

  it "solves example test case (part 1)" do
    sol = Solution13.new(@test_case)
    expect(sol.run).to eq 13
  end

  it "solves example test case (part 2)" do
    sol = Solution13.new(@test_case)
    expect(sol.run_2).to eq 140
  end

  it "solves big test (part 1)" do
    sol = Solution13.new(@big_test)
    expect(sol.run).to eq 6395
    # 466 is too low
  end

  it "solves big test (part 2)" do
    sol = Solution13.new(@big_test)
    expect(sol.run_2).to eq 24921
  end
end
