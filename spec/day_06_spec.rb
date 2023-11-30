require_relative '../lib/day_06'

RSpec.describe Solution06 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_06_1.txt'
    @big_test = './lib/inputs/big_tests/day_06.txt'
  end

  it "recognises when four chars are unique" do
    sol = Solution06.new(@test_case)
    expect(sol.unique("abcd")).to eq true
    expect(sol.unique("aacd")).to eq false
    expect(sol.unique("abbd")).to eq false
    expect(sol.unique("abca")).to eq false
  end
  it 'solves example test case (part 1)' do
    sol = Solution06.new(@test_case)
    expect(sol.run(0, 4)).to eq 7
    expect(sol.run(1, 4)).to eq 5
    expect(sol.run(2, 4)).to eq 6
    expect(sol.run(3, 4)).to eq 10
    expect(sol.run(4, 4)).to eq 11
  end
  
  it 'solves example test case (part 2)' do
    sol = Solution06.new(@test_case)
    expect(sol.run(0, 14)).to eq 19
    expect(sol.run(1, 14)).to eq 23
    expect(sol.run(2, 14)).to eq 23
    expect(sol.run(3, 14)).to eq 29
    expect(sol.run(4, 14)).to eq 26
  end
  
  it 'solves big test (part 1)' do
    sol = Solution06.new(@big_test)
    expect(sol.run(0, 4)).to eq 1953
  end

  it 'solves big test (part 2)' do
    sol = Solution06.new(@big_test)
    expect(sol.run(0, 14)).to eq 2301
  end
end
