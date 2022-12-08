require "day_08"

RSpec.describe Solution08 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_08_1.txt"
    @big_test = "./lib/inputs/big_tests/day_08.txt"
  end

  it "makes keys" do
    sol = Solution08.new(@test_case)
    expect(sol.make_key("row", 1, 4, 5)).to eq "1-4"
    expect(sol.make_key("row-rev", 0, 0, 5)).to eq "0-4"
    expect(sol.make_key("col", 1, 4, 5)).to eq "4-1"
    expect(sol.make_key("col-rev", 0, 0, 5)).to eq "4-0"
  end
  it "counts visible trees in a single array" do
    sol = Solution08.new(@test_case)
    expect(sol.visible([2, 5, 5, 1, 2], "row", 1)).to eq ["1-0", "1-1"]
  end

  it "solves example test case (part 1)" do
    sol = Solution08.new(@test_case)
    expect(sol.run).to eq 21
  end

  it "counts for a particular tree" do
    sol = Solution08.new(@test_case)
    expect(sol.count_from([1, 2], [-1, 0])).to eq 1
    expect(sol.count_from([1, 2], [1, 0])).to eq 2
    expect(sol.count_from([1, 2], [0, -1])).to eq 1
    expect(sol.count_from([1, 2], [0, 1])).to eq 2
  end

  it "finds scenic score for a tree" do
    sol = Solution08.new(@test_case)
    expect(sol.scenic_score(1, 2)).to eq 4
    expect(sol.scenic_score(3, 2)).to eq 8
  end

  it "solves example test case (part 2)" do
    sol = Solution08.new(@test_case)
    expect(sol.run_2).to eq 8
  end

  it "solves big test (part 1)" do
    sol = Solution08.new(@big_test)
    expect(sol.run).to eq 1672
  end

  it "solves big test (part 2)" do
    sol = Solution08.new(@big_test)
    expect(sol.run_2).to eq 327180
  end
end
