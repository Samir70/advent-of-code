require 'day_11'

RSpec.describe Solution11 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_11_1.txt'
    @big_test = './lib/inputs/big_tests/day_11.txt'
  end

  it "groups input by monkey" do
    sol = Solution11.new(@test_case)
    expect(sol.split_by_element([1, 2, 0, 4, 6, 8, 0, 9], 0)).to eq [[1, 2], [4, 6, 8], [9]]
  end

  it 'solves example test case (part 1)' do
    sol = Solution11.new(@test_case)
    expect(sol.run).to eq nil
  end

  it 'solves example test case (part 2)' do
    sol = Solution11.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution11.new(@big_test)
    expect(sol.run).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution11.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end