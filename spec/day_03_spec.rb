require 'day_03'

RSpec.describe Solution03 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_03_1.txt'
    @big_test = './lib/inputs/big_tests/day_03.txt'
  end

  it 'solves example test case' do
    sol = Solution03.new(@test_case)
    expect(sol.run).to eq nil
  end

  it 'solves big test' do
    sol = Solution03.new(@big_test)
    expect(sol.run).to eq nil
  end
end
