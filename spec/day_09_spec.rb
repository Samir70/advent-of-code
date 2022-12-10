require "day_09"

RSpec.describe Solution09 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_09_1.txt"
    @test_case_2 = "./lib/inputs/test_cases/day_09_2.txt"
    @big_test = "./lib/inputs/big_tests/day_09.txt"
  end

  context "toward_zero method" do
    it "decriments absolute value, keeping sign, never past zero" do
      expect(toward_zero(3)).to eq 2
      expect(toward_zero(-1)).to eq 0
      expect(toward_zero(0)).to eq 0
      expect(toward_zero(1)).to eq 0
      expect(toward_zero(-3)).to eq -2
    end
  end
  context "away_from_zero method" do
    it "decriments absolute value, keeping sign, never past zero" do
      expect(away_from_zero(3)).to eq 4
      expect(away_from_zero(-1)).to eq -2
      expect(away_from_zero(0)).to eq 1
      expect(away_from_zero(1)).to eq 2
      expect(away_from_zero(-3)).to eq -4
    end
  end

  context "One direction, 4 steps" do
    it "moves the head R 4" do
      sol = Solution09.new(@test_case)
      sol.move("R 4")
      expect(sol.head).to eq [0, 4]
      expect(sol.tail).to eq [0, 3]
    end
    it "moves the head L 4" do
      sol = Solution09.new(@test_case)
      sol.move("L 4")
      expect(sol.head).to eq [0, -4]
      expect(sol.tail).to eq [0, -3]
    end
    it "moves the head U 4" do
      sol = Solution09.new(@test_case)
      sol.move("U 4")
      expect(sol.head).to eq [4, 0]
      expect(sol.tail).to eq [3, 0]
    end
    it "moves the head D 4" do
      sol = Solution09.new(@test_case)
      sol.move("D 4")
      expect(sol.head).to eq [-4, 0]
      expect(sol.tail).to eq [-3, 0]
    end
  end
  context "multi command moves" do
    it "moves the head R 4; U 4" do
      sol = Solution09.new(@test_case)
      sol.move("R 4")
      sol.move("U 4")
      expect(sol.head).to eq [4, 4]
      expect(sol.tail).to eq [3, 4]
      expect(sol.tail_visited).to eq 7
    end
    it "moves the head R 4; U 4; L 3" do
      sol = Solution09.new(@test_case)
      sol.move("R 4")
      sol.move("U 4")
      sol.move("L 3")
      expect(sol.head).to eq [4, 1]
      expect(sol.tail).to eq [4, 2]
      expect(sol.tail_visited).to eq 9
    end
  end

  context "advent tests" do
    it "solves example test case (part 1)" do
      sol = Solution09.new(@test_case)
      expect(sol.run).to eq 13
    end

    it "solves example test case (part 2)" do
      sol = Solution09.new(@test_case)
      expect(sol.run_2).to eq 1
    end
    it "solves example test case (part 2b)" do
      sol = Solution09.new(@test_case_2)
      expect(sol.run_2).to eq 36
    end

    it "solves big test (part 1)" do
      sol = Solution09.new(@big_test)
      expect(sol.run).to eq 6354
    end

    it "solves big test (part 2)" do
      sol = Solution09.new(@big_test)
      expect(sol.run_2).to eq 2651
    end
  end
end
