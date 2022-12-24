require 'day_24'

RSpec.describe Solution24 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_24_1.txt'
    @big_test = './lib/inputs/big_tests/day_24.txt'
  end

  it "> Storms move and loop" do
    s = Storm.new(">", 2, 2, 4, 6)
    expect(s.loc).to eq [2, 2]
    s.move
    expect(s.loc).to eq [2, 3]
    s.move
    s.move
    s.move
    s.move
    expect(s.loc).to eq [2, 1]
  end
  it "< Storms move and loop" do
    s = Storm.new("<", 2, 2, 7, 6)
    expect(s.loc).to eq [2, 2]
    s.move
    expect(s.loc).to eq [2, 1]
    s.move
    expect(s.loc).to eq [2, 6]
  end
  it "^ Storms move and loop" do
    s = Storm.new("^", 2, 2, 6, 4)
    expect(s.loc).to eq [2, 2]
    s.move
    expect(s.loc).to eq [1, 2]
    s.move
    expect(s.loc).to eq [6, 2]
  end
  it "v Storms move and loop" do
    s = Storm.new("v", 2, 2, 4, 3)
    expect(s.loc).to eq [2, 2]
    s.move
    expect(s.loc).to eq [3, 2]
    s.move
    s.move
    expect(s.loc).to eq [1, 2]
  end

  it "makes the right number of storms" do
    sol = Solution24.new(@test_case)
    expect(sol.storms.length).to eq 19
    expect(sol.max_r).to eq 4
    expect(sol.max_c).to eq 6
  end

  it 'solves example test case (part 1)' do
    sol = Solution24.new(@test_case)
    expect(sol.run).to eq 18
  end

  it 'solves example test case (part 2)' do
    sol = Solution24.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution24.new(@big_test)
    expect(sol.run).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution24.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
