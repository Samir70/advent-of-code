require 'day_07'

RSpec.describe Solution07 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_07_1.txt'
    @big_test = './lib/inputs/big_tests/day_07.txt'
  end

  it "finds the right number of directories" do
    sol = Solution07.new(@test_case)
    # expect(sol.directories.uniq.join("-")).to eq "/-a-d-e"
    expect(sol.directories.uniq.length).to eq 4
  end
  it 'solves example test case (part 1)' do
    sol = Solution07.new(@test_case)
    expect(sol.run).to eq 95437
  end

  it 'solves example test case (part 2)' do
    sol = Solution07.new(@test_case)
    expect(sol.run_2).to eq 24933642
  end

  it 'solves big test (part 1)' do
    sol = Solution07.new(@big_test)
    expect(sol.run).to eq 1084134
    # 911275 is too low
  end

  it 'solves big test (part 2)' do
    sol = Solution07.new(@big_test)
    expect(sol.run_2).to eq nil
    # 25622272 is too high
  end
end