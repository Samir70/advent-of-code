require "day_03"

RSpec.describe Solution03 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_03_1.txt"
    @big_test = "./lib/inputs/big_tests/day_03.txt"
  end

  it "splits rucksack contents into two halves" do
    sol = Solution03.new(@test_case)
    expect(sol.splitRucks(0)).to eq ["vJrwpWtwJgWr", "hcsFMMfFFhFp"]
  end
  it "find an overlap in parts of sacks" do
    sol = Solution03.new(@test_case)
    expect(sol.overlap("vJrwpWtwJgWr", "hcsFMMfFFhFp")).to eq ["p"]
  end
  it "finds priorities" do
    sol = Solution03.new(@test_case)
    expect(sol.priority("p")).to eq 16
    expect(sol.priority("L")).to eq 38
    expect(sol.priority("Z")).to eq 52
  end
  it "find all overlaps of all sack-halves" do
    sol = Solution03.new(@test_case)
    expect(sol.overlaps).to eq [16, 38, 42, 22, 20, 19]
  end
  it "solves example test case (part 1)" do
    sol = Solution03.new(@test_case)
    expect(sol.run).to eq 157
  end
  it "groups sacks in 3s" do
    sol = Solution03.new(@test_case)
    expect(sol.groupIn3s[0]).to eq ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg"]
    expect(sol.groupIn3s[1]).to eq ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"]
  end
  it "findBadge: finds overlap between three sacks" do
    sol = Solution03.new(@test_case)
    expect(sol.findBadge("vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg")).to eq "r"
  end
  it "getBadges: finds all badges" do
    sol = Solution03.new(@test_case)
    expect(sol.getBadges).to eq ["r", "Z"]
  end
  it "solves example test case (part 2)" do
    sol = Solution03.new(@test_case)
    expect(sol.run_2).to eq 70
  end

  it "solves big test (part 1)" do
    sol = Solution03.new(@big_test)
    expect(sol.run).to eq 7766
  end
  it "solves big test (part 2)" do
    sol = Solution03.new(@big_test)
    expect(sol.run_2).to eq 2415
  end
end
