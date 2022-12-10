require 'day_22'

RSpec.describe Solution22 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_22_1.txt'
    @big_test = './lib/inputs/big_tests/day_22.txt'
  end

  it 'solves example test case (part 1)' do
    sol = Solution22.new(@test_case)
    expect(sol.run).to eq nil
  end

  it 'solves example test case (part 2)' do
    sol = Solution22.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution22.new(@big_test)
    expect(sol.run).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution22.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
