require 'day_23'

RSpec.describe Solution23 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_23_1.txt'
    @big_test = './lib/inputs/big_tests/day_23.txt'
  end

it "finds location after a journey" do
  expect(make_journey([1,5], "nw")).to eq [0,4]
end

  it "finds nswe of a point" do
    expect(nswe([1, 5])).to eq [[[0,4], [0, 5], [0, 6]], [[2,4], [2,5], [2,6]], [[2,4], [1,4], [0,4]], [[2,6], [1,6], [0,6]]]
  end

  it "loads data as a flexi-grid" do
    sol = Solution23.new(@test_case)
    expect(sol.grid.elves.length).to eq 22
    expect(sol.grid.min_row).to eq 1
    expect(sol.grid.max_row).to eq 7
    expect(sol.grid.min_col).to eq 1
    expect(sol.grid.max_col).to eq 7
    expect(sol.grid.elf_at([1, 5])).to eq true
  end

  it "converts nswe to options for an elf" do
    sol = Solution23.new(@test_case)
    expect(sol.options([1, 5])).to eq [true, false, false, true]
    expect(sol.options([2, 4])).to eq [false, false, false, false]
    expect(sol.options([5, 1])).to eq [false, false, true, false]
  end

  it "reports number of empties in grid" do
    sol = Solution23.new(@test_case)
    expect(sol.grid.empties).to eq 27
  end

  it 'solves example test case (part 1)' do
    sol = Solution23.new(@test_case)
    expect(sol.run).to eq 110
  end
  it 'solves big test (part 1)' do
    sol = Solution23.new(@big_test)
    expect(sol.run).to eq 3871
    # 4031 is too high
  end

  it 'solves example test case (part 2)' do
    sol = Solution23.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution23.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
