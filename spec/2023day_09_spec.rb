require '2023day_09'

RSpec.describe Solution09 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/2023day_09_1.txt'
    @big_test = './lib/inputs/big_tests/2023day_09.txt'
  end

  it "continues a sequence" do
    sol = Solution09.new(@test_case)
    expect(sol.findNext("3 3 3 3 3 3 3".split(" ").map(&:to_i))).to eq 3
    expect(sol.findNext("0 3 6 9 12 15".split(" ").map(&:to_i))).to eq 18
    expect(sol.findNext("1 3 6 10 15 21".split(" ").map(&:to_i))).to eq 28
    expect(sol.findNext("10 13 16 21 30 45".split(" ").map(&:to_i))).to eq 68
  end
  it "finds previous of a sequence" do
    sol = Solution09.new(@test_case)
    expect(sol.findNext("3 3 3 3 3 3 3".split(" ").reverse().map(&:to_i))).to eq 3
    expect(sol.findNext("0 3 6 9 12 15".split(" ").reverse().map(&:to_i))).to eq -3
    expect(sol.findNext("1 3 6 10 15 21".split(" ").reverse().map(&:to_i))).to eq 0
    expect(sol.findNext("10 13 16 21 30 45".split(" ").reverse().map(&:to_i))).to eq 5
  end

  it 'solves example test case (part 1)' do
    sol = Solution09.new(@test_case)
    expect(sol.run).to eq 114
  end

  it 'solves example test case (part 2)' do
    sol = Solution09.new(@test_case)
    expect(sol.run_2).to eq 2
  end

  it 'solves big test (part 1)' do
    sol = Solution09.new(@big_test)
    expect(sol.run).to eq 1772145754
  end

  it 'solves big test (part 2)' do
    sol = Solution09.new(@big_test)
    expect(sol.run_2).to eq 867
  end
end
