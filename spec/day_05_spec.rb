require "day_05"

RSpec.describe Solution05 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_05_1.txt"
    @big_test = "./lib/inputs/big_tests/day_05.txt"
  end

  it "has correct number of piles" do
    sol = Solution05.new(@test_case)
    expect(sol.piles.length).to eq 3
  end
  it "piles have correct contents" do
    sol = Solution05.new(@test_case)
    expect(sol.piles[0]).to eq ["N", "Z"]
    expect(sol.piles[1]).to eq ["D", "C", "M"]
    expect(sol.piles[2]).to eq ["P"]
  end
  it "can list the top of the piles" do
    sol = Solution05.new(@test_case)
    expect(sol.give_tops).to eq "NDP"
  end
  it "lists instructions" do
    sol = Solution05.new(@test_case)
    expect(sol.instructions.length).to eq 4
    expect(sol.instructions[3]).to eq "move 1 from 1 to 2"
  end
  it "splits instruction into 3 numbers" do
    sol = Solution05.new(@test_case)
    expect(sol.get_detail_todo("move 1 from 1 to 2")).to eq [1, 1, 2]
    expect(sol.get_detail_todo("move 10 from 123 to 24")).to eq [10, 123, 24]
  end
  it "follows instructions to move crates" do
    sol = Solution05.new(@test_case)
    sol.move_crates([1, 2, 1], 9000)
    expect(sol.piles[0]).to eq ["D", "N", "Z"]
    expect(sol.piles[1]).to eq ["C", "M"]
    expect(sol.piles[2]).to eq ["P"]
  end

  it "solves example test case (part 1)" do
    sol = Solution05.new(@test_case)
    expect(sol.run(9000)).to eq "CMZ"
  end
  it "solves example test case (part 2)" do
    sol = Solution05.new(@test_case)
    expect(sol.run(9001)).to eq "MCD"
  end

  it "solves big test (part 1)" do
    sol = Solution05.new(@big_test)
    expect(sol.run(9000)).to eq "TGWSMRBPN"
  end
  it "solves big test (part 2)" do
    sol = Solution05.new(@big_test)
    expect(sol.run(9001)).to eq "TZLTLWRNF"
  end
end
