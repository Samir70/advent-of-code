require "day_11"

RSpec.describe Solution11 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_11_1.txt"
    @big_test = "./lib/inputs/big_tests/day_11.txt"
  end

  it "groups input by monkey" do
    sol = Solution11.new(@test_case)
    expect(sol.split_by_element([1, 2, 0, 4, 6, 8, 0, 9], 0)).to eq [[1, 2], [4, 6, 8], [9]]
  end

  it "extracts Monkey data" do
    sol = Solution11.new(@test_case)
    expect(sol.monkeys.length).to 4
    expect(sol.monkeys.first.items).to eq [79, 98]
    expect(sol.monkeys.first.operation).to eq ["*", 19]
    expect(sol.monkeys.first.div_test).to eq 23
    expect(sol.monkeys.first.true_monkey).to eq 2
    expect(sol.monkeys.first.false_monkey).to eq 3
  end

  it "modifys after monkey 0's turn" do
    sol = Solution11.new(@test_case)
    expect(sol.monkeys[0].items).to eq []
    expect(sol.monkeys[1].items).to eq [54, 65, 75, 74]
    expect(sol.monkeys[2].items).to eq [79, 60, 97]
    expect(sol.monkeys[3].items).to eq [74, 500, 620]
    sol.take_turn(0)
  end

  it "solves example test case (part 1)" do
    sol = Solution11.new(@test_case)
    expect(sol.run).to eq nil
  end

  it "solves example test case (part 2)" do
    sol = Solution11.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it "solves big test (part 1)" do
    sol = Solution11.new(@big_test)
    expect(sol.run).to eq nil
  end

  it "solves big test (part 2)" do
    sol = Solution11.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
