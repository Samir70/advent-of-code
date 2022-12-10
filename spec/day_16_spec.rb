require 'day_16'

RSpec.describe Solution16 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_16_1.txt'
    @big_test = './lib/inputs/big_tests/day_16.txt'
  end

  it 'solves example test case (part 1)' do
    sol = Solution16.new(@test_case)
    expect(sol.run).to eq nil
  end

  it 'solves example test case (part 2)' do
    sol = Solution16.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution16.new(@big_test)
    expect(sol.run).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution16.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
