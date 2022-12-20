require "day_20"

RSpec.describe Solution20 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_20_1.txt"
    @big_test = "./lib/inputs/big_tests/day_20.txt"
  end

  describe MyList do
    it "gets the nth element of a list" do
      m = MyList.new([1, 2, -3, 4, 0, 3, -2])
      expect(m.get(1000)).to eq 4
      expect(m.get(2000)).to eq -3
      expect(m.get(3000)).to eq 2
    end
    it "mixes array" do
      m = MyList.new([1, 2, -3, 3, -2, 0, 4])
      m.mix
      expect(m.list).to eq [1, 2, -3, 4, 0, 3, -2]
    end
  end

  context "main tests" do
    it "solves example test case (part 1)" do
      sol = Solution20.new(@test_case)
      expect(sol.run).to eq 3
    end

    it "solves example test case (part 2)" do
      sol = Solution20.new(@test_case)
      expect(sol.run_2).to eq nil
    end

    it "solves big test (part 1)" do
      sol = Solution20.new(@big_test)
      expect(sol.run).to eq 988
    end

    it "solves big test (part 2)" do
      sol = Solution20.new(@big_test)
      expect(sol.run_2).to eq nil
    end
  end
end
