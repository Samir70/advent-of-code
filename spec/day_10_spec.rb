require 'day_10'

RSpec.describe Solution10 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_10_1.txt'
    @big_test = './lib/inputs/big_tests/day_10.txt'
  end

  it "can follow a noop instruction" do
    sol = Solution10.new(@test_case)
    sol.cpu("noop")
    expect(sol.x).to eq [1, 1]
  end

  it "can follow an addx instruction" do
    sol = Solution10.new(@test_case)
    sol.cpu("addx 3")
    expect(sol.x).to eq [1, 1, 4]
  end

  it "can find the signal strength at given time" do
    sol = Solution10.new(@test_case)
    sol.run
    expect(sol.sig_strength(20)).to eq 21*20
    expect(sol.sig_strength(60)).to eq 19*60
  end

  it "can find the strengths at many times" do
    sol = Solution10.new(@test_case)
    sol.run
    expect(sol.sigs([20, 60, 100, 140, 180, 220])).to eq [420, 1140, 1800, 2940, 2880, 3960]
  end

  it "detects if sprite is at print point" do
    sol = Solution10.new(@test_case)
    sol.run
    expect(sol.print?(1)).to eq true
    expect(sol.print?(2)).to eq true
    expect(sol.print?(3)).to eq false
    expect(sol.print?(4)).to eq false
    expect(sol.print?(5)).to eq true
    expect(sol.print?(10)).to eq true
  end

  it "finds finds all print points" do
    sol = Solution10.new(@test_case)
    sol.run
    sol.run_2
  end

  it 'solves example test case (part 1)' do
    sol = Solution10.new(@test_case)
    sol.run
    expect(sol.sigs([20, 60, 100, 140, 180, 220]).sum).to eq 13140
  end

  xit 'solves example test case (part 2)' do
    sol = Solution10.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution10.new(@big_test)
    sol.run
    expect(sol.sigs([20, 60, 100, 140, 180, 220]).sum).to eq 13740
  end

  it 'solves big test (part 2)' do
    sol = Solution10.new(@big_test)
    sol.run
    sol.run_2 #gives ZUPRFECL
  end
end
