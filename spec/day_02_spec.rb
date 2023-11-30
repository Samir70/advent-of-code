require_relative '../lib/day_02'

RSpec.describe Solution02 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_02_1.txt'
    @big_test = './lib/inputs/big_tests/day_02.txt'
  end

  it "converts letters to numbers" do
    sol = Solution02.new(@test_case)
    expect(sol.convert("C")).to eq 3
    expect(sol.convert("Z")).to eq 3
    expect(sol.convert("B")).to eq 2
    expect(sol.convert("Y")).to eq 2
    expect(sol.convert("A")).to eq 1
    expect(sol.convert("X")).to eq 1
  end

  it "scores a round from point of view of second player" do
    sol = Solution02.new(@test_case)
    expect(sol.score(1, 1)).to eq 4
    expect(sol.score(2, 1)).to eq 1
    expect(sol.score(1, 2)).to eq 8
    expect(sol.score(1, 3)).to eq 3
  end

  it "scores a round of rps" do
    sol = Solution02.new(@test_case)
    expect(sol.score(1, 2)).to eq 8
    expect(sol.score(2, 1)).to eq 1
    expect(sol.score(3, 3)).to eq 6
  end

  it "works out what to play" do
    sol = Solution02.new(@test_case)
    expect(sol.choose_rps("A Y")).to eq "A"
    expect(sol.choose_rps("B X")).to eq "A"
    expect(sol.choose_rps("C Z")).to eq "A"
    expect(sol.choose_rps("B Z")).to eq "C"
    expect(sol.choose_rps("A Z")).to eq "B"
  end

  it 'solves example test case (part 1)' do
    sol = Solution02.new(@test_case)
    expect(sol.run).to eq 15
  end
  it 'solves example test case (part 2)' do
    sol = Solution02.new(@test_case)
    expect(sol.run_2).to eq 12
  end

  it 'solves big test (part 1)' do
    sol = Solution02.new(@big_test)
    expect(sol.run).to eq 10310
  end
  it 'solves big test (part 2)' do
    sol = Solution02.new(@big_test)
    expect(sol.run_2).to eq 14859
  end
end
