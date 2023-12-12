require "2023day_12"

RSpec.describe Solution12 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_12_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_12.txt"
  end

  it "finds current count of damaged in string" do
    sol = Solution12.new(@test_case)
    expect(sol.countDamaged("???.###")).to eq [3]
    expect(sol.countDamaged("?#?#?#?#?#?#?#?")).to eq [1, 1, 1, 1, 1, 1, 1]
  end

  it "splits line into str and counts" do
    sol = Solution12.new(@test_case)
    expect(sol.parse("???.### 1,1,3").springs).to eq "???.###"
    expect(sol.parse("???.### 1,1,3").counts).to eq [1, 1, 3]
    expect(sol.parse("???.### 1,1,3").totalDamaged).to eq 5
    expect(sol.parse("???.### 1,1,3").currentCount).to eq [3]
    expect(sol.parse("?#?#?#?#?#?#?#? 1,3,1,6").totalDamaged).to eq 11
  end

  it "counts ways to complete" do
    sol = Solution12.new(@test_case)
    expect(sol.countWays(sol.parse("???.### 1,1,3"), 0)).to eq 1
    expect(sol.countWays(sol.parse(".??..??...?##. 1,1,3"), 0)).to eq 4
    expect(sol.countWays(sol.parse("?#?#?#?#?#?#?#? 1,3,1,6"), 0)).to eq 1
  end

  it "unfolds an input" do
    sol = Solution12.new(@test_case)
    expect(sol.unfold("???.### 1,1,3")).to eq "???.###????.###????.###????.###????.### 1,1,3,1,1,3,1,1,3,1,1,3,1,1,3"
  end

  it "finds smallest str for given count" do
    sol = Solution12.new(@test_case)
    expect(sol.findGoodStr([3, 2, 1])).to eq "###.##.#" # compare to ?###????????
  end

  it "counts ways from goodStr to springs" do
    sol = Solution12.new(@test_case)
    expect(sol.countWays2([1, 1], "##?????.")).to eq 0
    expect(sol.countWays2([2, 1, 1], "??.##?????.")).to eq 3
    expect(sol.countWays2([5], "#?????#")).to eq 0
    expect(sol.countWays2([3, 1, 1, 5], "????##??#?#?????#")).to eq 2
    expect(sol.countWays2([2, 3, 1, 1, 5], "???????##??#?#?????#")).to eq 9
    expect(sol.countWays2([5], "#??####?")).to eq 0
    expect(sol.countWays2([3, 2, 1], "?###????????")).to eq 10
    expect(sol.countWays2([1, 1, 3], ".??..??...?##.")).to eq 4
    expect(sol.countWays2([5, 1, 5], "???#???.#??####?")).to eq 6
  end

  it "solves example test case (part 1)" do
    sol = Solution12.new(@test_case)
    expect(sol.run).to eq 21
  end
  it "solves big test (part 1)" do
    sol = Solution12.new(@big_test)
    expect(sol.run).to eq 7402
  end

  it "solves example test case (part 2)" do
    sol = Solution12.new(@test_case)
    expect(sol.run_2).to eq 525152
  end

  it "solves big test (part 2)" do
    sol = Solution12.new(@big_test)
    expect(sol.run_2).to eq 3384337640277
  end
end
