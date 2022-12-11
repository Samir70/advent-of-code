require "day_11"

RSpec.describe Solution11 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_11_1.txt"
    @big_test = "./lib/inputs/big_tests/day_11.txt"
  end

  it "performs operations given in text" do
    sol = Solution11.new(@test_case)
    expect(sol.do_op(5, "*", 6)).to eq 30
    expect(sol.do_op(5, "+", 6)).to eq 11
    expect(sol.do_op(5, "*", 0)).to eq 25
  end

  it "extracts Monkey data" do
    sol = Solution11.new(@test_case)
    expect(sol.monkeys.length).to eq 4
    expect(sol.monkeys.first.items).to eq [79, 98]
    expect(sol.monkeys.first.operation).to eq ["*", 19]
    expect(sol.monkeys.first.div_test).to eq 23
    expect(sol.monkeys.first.true_monkey).to eq 2
    expect(sol.monkeys.first.false_monkey).to eq 3
    expect(sol.monkeys.first.activity).to eq 0
  end

  it "modifys after monkey 0's turn" do
    sol = Solution11.new(@test_case)
    sol.take_turn(0)
    expect(sol.monkeys[0].items).to eq []
    expect(sol.monkeys[1].items).to eq [54, 65, 75, 74]
    expect(sol.monkeys[2].items).to eq [79, 60, 97]
    expect(sol.monkeys[3].items).to eq [74, 500, 620]
    expect(sol.monkeys.first.activity).to eq 2
  end

  describe "taking rounds" do
    it "monkeys have correct items after round 1" do
      sol = Solution11.new(@test_case)
      sol.play_a_round
      expect(sol.monkeys[0].items).to eq [20, 23, 27, 26]
      expect(sol.monkeys[1].items).to eq [2080, 25, 167, 207, 401, 1046]
      expect(sol.monkeys[2].items).to eq []
      expect(sol.monkeys[3].items).to eq []
      expect(sol.monkeys[0].activity).to eq 2
      expect(sol.monkeys[1].activity).to eq 4
      expect(sol.monkeys[2].activity).to eq 3
      expect(sol.monkeys[3].activity).to eq 5
    end
    it "monkeys have correct items after round 2" do
      sol = Solution11.new(@test_case)
      sol.play_a_round
      sol.play_a_round
      expect(sol.monkeys[0].items).to eq [695, 10, 71, 135, 350]
      expect(sol.monkeys[1].items).to eq [43, 49, 58, 55, 362]
      expect(sol.monkeys[2].items).to eq []
      expect(sol.monkeys[3].items).to eq []
    end
    it "monkeys have correct items after round 3" do
      sol = Solution11.new(@test_case)
      sol.play_a_round
      sol.play_a_round
      sol.play_a_round
      expect(sol.monkeys[0].items).to eq [16, 18, 21, 20, 122]
      expect(sol.monkeys[1].items).to eq [1468, 22, 150, 286, 739]
      expect(sol.monkeys[2].items).to eq []
      expect(sol.monkeys[3].items).to eq []
    end
    it "monkeys have correct items after round 20" do
      sol = Solution11.new(@test_case)
      20.times do
        sol.play_a_round
      end
      expect(sol.monkeys[0].items).to eq [10, 12, 14, 26, 34]
      expect(sol.monkeys[1].items).to eq [245, 93, 53, 199, 115]
      expect(sol.monkeys[2].items).to eq []
      expect(sol.monkeys[3].items).to eq []
      expect(sol.monkeys[0].activity).to eq 101
      expect(sol.monkeys[1].activity).to eq 95
      expect(sol.monkeys[2].activity).to eq 7
      expect(sol.monkeys[3].activity).to eq 105
      expect(sol.monkey_business).to eq 10605
    end
  end

  it "solves example test case (part 1)" do
    sol = Solution11.new(@test_case)
    expect(sol.run).to eq 10605
  end

  it "solves example test case (part 2)" do
    sol = Solution11.new(@test_case)
    expect(sol.run_2).to eq 2713310158
  end

  it "solves big test (part 1)" do
    sol = Solution11.new(@big_test)
    expect(sol.run).to eq 111210
  end

  it "solves big test (part 2)" do
    sol = Solution11.new(@big_test)
    expect(sol.run_2).to eq 15447387620
    # 17595917630 is too high
  end
end
