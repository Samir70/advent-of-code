require "2023day_13"

RSpec.describe Solution13 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_13_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_13.txt"
  end

  it "splits input into patterns" do
    sol = Solution13.new(@test_case)
    expect(sol.getPatterns.length).to eq 2
    expect(sol.getPatterns.first).to eq ["#.##..##.", "..#.##.#.", "##......#", "##......#", "..#.##.#.", "..##..##.", "#.#.##.#."]
  end

  it "calcs mirror intervals" do
    sol = Solution13.new(@test_case)
    expect(sol.calcIntervals(7, 0)).to eq [[0, 0], [1, 1]]
    expect(sol.calcIntervals(7, 1)).to eq [[0, 1], [2, 3]]
    expect(sol.calcIntervals(7, 3)).to eq [[1, 3], [4, 6]]
  end

  it "finds horizontal mirrors" do
    sol = Solution13.new(@test_case)
    expect(sol.findHorMirror(sol.getPatterns[0])).to eq 0
    expect(sol.findHorMirror(sol.getPatterns[1])).to eq 4
  end
  it "finds vertical mirrors" do
    sol = Solution13.new(@test_case)
    expect(sol.findVertMirror(sol.getPatterns[0])).to eq 5
    expect(sol.findVertMirror(sol.getPatterns[1])).to eq 0
  end
  it "finds horizontal smudged mirrors" do
    sol = Solution13.new(@test_case)
    expect(sol.findHorSmudgedMirror(sol.getPatterns[0])).to eq 3
    expect(sol.findHorSmudgedMirror(sol.getPatterns[1])).to eq 1
  end
  it "finds vertical mirrors" do
    sol = Solution13.new(@test_case)
    expect(sol.findVertSmudgedMirror(sol.getPatterns[0])).to eq 0
    expect(sol.findVertSmudgedMirror(sol.getPatterns[1])).to eq 0
  end

  it "counts diffs between two strings" do
    sol = Solution13.new(@test_case)
    expect(sol.countDiffs("#...##..#", "#....#..#")).to eq 1
    expect(sol.countDiffs("#...##..#", "#...##..#")).to eq 0
    expect(sol.countDiffs("#...##..#", "#...###.#")).to eq 1
  end

  it "solves example test case (part 1)" do
    sol = Solution13.new(@test_case)
    expect(sol.run).to eq 405
  end

  it "solves example test case (part 2)" do
    sol = Solution13.new(@test_case)
    expect(sol.run_2).to eq 400
  end

  it "solves big test (part 1)" do
    sol = Solution13.new(@big_test)
    expect(sol.run).to eq 30518
    # 30728 is too high
  end

  it "solves big test (part 2)" do
    sol = Solution13.new(@big_test)
    expect(sol.run_2).to eq 36735
  end
end
