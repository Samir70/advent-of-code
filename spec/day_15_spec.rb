require "day_15"

RSpec.describe Solution15 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_15_1.txt"
    @big_test = "./lib/inputs/big_tests/day_15.txt"
  end

  it "extracts points of sensor and beacon" do
    sol = Solution15.new(@test_case)
    sensor, beacon = sol.extract_points("Sensor at x=2, y=18: closest beacon is at x=-2, y=15")
    expect(sensor).to eq [18, 2]
    expect(beacon).to eq [15, -2]
  end
  it "works out manhattan distance between two points" do
    sol = Solution15.new(@test_case)
    expect(sol.m_dist([2, 18], [-2, 15])).to eq 7
    expect(sol.m_dist([-2, 15], [2, 18])).to eq 7
  end
  it "creates intervals for sensor at [8, 7], m_dist = 9" do
    sol = Solution15.new(@test_case)
    results = sol.manhattan_circle([7, 8], 9)
    expect(results.length).to eq 19
    expect(results).to eq [{ 7 => [-1, 17] },
                           { 8 => [0, 16] },
                           { 6 => [0, 16] },
                           { 9 => [1, 15] },
                           { 5 => [1, 15] },
                           { 10 => [2, 14] },
                           { 4 => [2, 14] },
                           { 11 => [3, 13] },
                           { 3 => [3, 13] },
                           { 12 => [4, 12] },
                           { 2 => [4, 12] },
                           { 13 => [5, 11] },
                           { 1 => [5, 11] },
                           { 14 => [6, 10] },
                           { 0 => [6, 10] },
                           { 15 => [7, 9] },
                           { -1 => [7, 9] },
                           { 16 => [8, 8] },
                           { -2 => [8, 8] }]

    # expect(results.first).to eq {7 => [[-1, 17]]}
    # expect(results[1]).to eq {8 => [[0, 16]]}
  end

  it "solves example test case (part 1)" do
    sol = Solution15.new(@test_case)
    expect(sol.run).to eq nil
  end

  it "solves example test case (part 2)" do
    sol = Solution15.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it "solves big test (part 1)" do
    sol = Solution15.new(@big_test)
    expect(sol.run).to eq nil
  end

  it "solves big test (part 2)" do
    sol = Solution15.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
