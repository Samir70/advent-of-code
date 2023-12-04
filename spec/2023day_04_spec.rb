require "2023day_04"

RSpec.describe Solution04 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_04_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_04.txt"
  end

  it "splits line into numbers" do
    sol = Solution04.new(@test_case)
    res = sol.getNums("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
    expect(res.winning).to eq [41, 48, 83, 86, 17]
    expect(res.have).to eq [83, 86, 6, 31, 17, 9, 48, 53]
  end

  it "counts winners" do
    sol = Solution04.new(@test_case)
    res = sol.countWins([41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53])
    expect(res).to eq 4
  end

  it "solves example test case (part 1)" do
    sol = Solution04.new(@test_case)
    expect(sol.run).to eq 13
  end

  it "solves example test case (part 2)" do
    sol = Solution04.new(@test_case)
    expect(sol.run_2).to eq 30
  end

  it "solves big test (part 1)" do
    sol = Solution04.new(@big_test)
    expect(sol.run).to eq 21485
  end

  it "solves big test (part 2)" do
    sol = Solution04.new(@big_test)
    expect(sol.run_2).to eq 11024379
  end
end
