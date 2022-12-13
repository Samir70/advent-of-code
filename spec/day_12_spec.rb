require "day_12 copy 2"

RSpec.describe Solution12 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_12_1.txt"
    @big_test = "./lib/inputs/big_tests/day_12.txt"
  end

  it "finds poss next steps" do
    sol = Solution12.new(@test_case)
    # order udlr
    expect(sol.can_go_to_from(2, 2)).to eq [[1, 2], [3, 2], [2, 1]]
    expect(sol.can_go_to_from(2, 4)).to eq [[1, 4], [3, 4], [2, 3], [2, 5]]
    expect(sol.can_go_to_from(3, 5)).to eq [[4, 5], [3, 4], [3, 6]]
  end
  it "finds poss previous square" do
    sol = Solution12.new(@test_case)
    # order udlr
    expect(sol.poss_previous(2, 2)).to eq [[1, 2], [3, 2], [2, 1],[2, 3]]
    expect(sol.poss_previous(2, 4)).to eq [[1, 4], [2, 5]]
    expect(sol.poss_previous(3, 5)).to eq [[2, 5], [3, 4], [3, 6]]
  end

  xit "finds E" do
    sol = Solution12.new(@test_case)
    expect(sol.find_e).to eq true
    expect(sol.dist_from_e).to eq [
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 0, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000]
    ]
    expect(sol.new_stack).to eq [[2, 5]]
  end

  xit "updates distances to E" do
    sol = Solution12.new(@test_case)
    sol.find_e
    sol.update_dists(2, 5)
    expect(sol.dist_from_e).to eq [
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 0, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000], 
      [100000, 100000, 100000, 100000, 100000, 100000, 100000, 100000]
    ]
    expect(sol.new_stack).to eq [[2, 5], [2, 4]]
  end

  context "proper tests" do
    it "solves example test case (part 1)" do
      sol = Solution12.new(@test_case)
      expect(sol.run(0, 0)).to eq 31
    end

    it "solves example test case (part 2)" do
      sol = Solution12.new(@test_case)
      expect(sol.run_2(0, 0)).to eq 29
    end

    it "solves big test (part 1)" do
      sol = Solution12.new(@big_test)
      expect(sol.run(20, 0)).to eq 425
      # 427 is too high
    end

    it "solves big test (part 2)" do
      sol = Solution12.new(@big_test)
      expect(sol.run_2(20, 0)).to eq 418
    end
  end
end
