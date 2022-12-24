require 'day_24'

RSpec.describe Solution24 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_24_1.txt'
    @big_test = './lib/inputs/big_tests/day_24.txt'
  end

  it "finds width and height of valley" do
    sol = Solution24.new(@test_case)
    expect(sol.width).to eq 6
    expect(sol.height).to eq 4
    expect(sol.lcm).to eq 12
  end

  it "works out visit times of a storm along a row" do
    sol = Solution24.new(@test_case)
    expect(sol.visit_times(">", [2, 2])[:row]).to eq({:base => 6, :times => [0, 1, 2, 3, 4, 5]})
    expect(sol.visit_times(">", [2, 3])[:row]).to eq({:base => 6, :times => [5, 0, 1, 2, 3, 4]})
    expect(sol.visit_times("^", [2, 6])[:row]).to eq({:base => 4, :times => [nil, nil, nil, nil, 0, nil]})
    expect(sol.visit_times("<", [2, 7])[:row]).to eq({:base => 6, :times => [5, 4, 3, 2, 1, 0]})
    expect(sol.visit_times("<", [2, 5])[:row]).to eq({:base => 6, :times => [3, 2, 1, 0, 5, 4]})
    expect(sol.visit_times("v", [4, 3])[:row]).to eq({:base => 4, :times => [nil, 0, nil, nil, nil, nil]})
  end
  it "works out visit times of a storm along a column" do
    sol = Solution24.new(@test_case)
    expect(sol.visit_times(">", [2, 1])[:col]).to eq({:base => 6, :times => [0, nil, nil, nil]})
    expect(sol.visit_times("^", [2, 6])[:col]).to eq({:base => 4, :times => [0, 3, 2, 1]})
    expect(sol.visit_times("<", [2, 7])[:col]).to eq({:base => 6, :times => [0, nil, nil, nil]})
    expect(sol.visit_times("<", [3, 6])[:col]).to eq({:base => 6, :times => [nil, 0, nil, nil]})
    expect(sol.visit_times("v", [4, 3])[:col]).to eq({:base => 4, :times => [2, 3, 0, 1]})
  end

  it "calculates visit times for each square" do
    sol = Solution24.new(@test_case)
    sol.run
    expect(sol.storm_at[0][0]).to eq Set.new()
    expect(sol.storm_at[2][2]).to eq Set.new([0, 6, 5, 11, 3, 9])
    expect(sol.storm_at[3][3]).to eq Set.new([0, 6, 3, 9, 4, 10, 3, 7, 11, 2, 6, 10])
  end

  it 'solves example test case (part 1)' do
    sol = Solution24.new(@test_case)
    expect(sol.run).to eq 18
  end

  it 'solves example test case (part 2)' do
    sol = Solution24.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution24.new(@big_test)
    expect(sol.run).to eq 221
    # 187 is too low
  end

  it 'solves big test (part 2)' do
    sol = Solution24.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
