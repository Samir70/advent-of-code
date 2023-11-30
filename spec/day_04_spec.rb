require_relative '../lib/day_04'

RSpec.describe Solution04 do
  before(:each) do
    @test_case = '../lib/inputs/test_cases/day_04_1.txt'
    @big_test = '../lib/inputs/big_tests/day_04.txt'
  end

  it "extracts intervals from string" do
    sol = Solution04.new(@test_case)
    expect(sol.get_intervals('2-4,6-8')).to eq [[2, 4], [6, 8]]
  end

  it "knows when one intervals is subset of another" do
    sol = Solution04.new(@test_case)
    expect(sol.has_subset?([2, 4], [6, 8])).to eq false
    expect(sol.has_subset?([6, 6], [4, 6])).to eq true
    expect(sol.has_subset?([2, 8], [3, 7])).to eq true
  end
  it "knows when pair of intervals overlap" do
    sol = Solution04.new(@test_case)
    expect(sol.has_overlap?([2, 4], [6, 8])).to eq false
    expect(sol.has_overlap?([5, 7], [7, 9])).to eq true
    expect(sol.has_overlap?([6, 6], [4, 6])).to eq true
    expect(sol.has_overlap?([2, 8], [3, 7])).to eq true
  end

  it 'solves example test case' do
    sol = Solution04.new(@test_case)
    expect(sol.count_subsets).to eq 2
  end
  it 'solves example test case' do
    sol = Solution04.new(@test_case)
    expect(sol.count_overlaps).to eq 4
  end

  it 'solves big test (part 1)' do
    sol = Solution04.new(@big_test)
    expect(sol.count_subsets).to eq 644
  end
  it 'solves big test (part 1)' do
    sol = Solution04.new(@big_test)
    expect(sol.count_overlaps).to eq 926
  end
end
