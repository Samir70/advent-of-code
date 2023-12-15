require '2023day_15'

RSpec.describe Solution15 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/2023day_15_1.txt'
    @big_test = './lib/inputs/big_tests/2023day_15.txt'
  end

  it "returns ascii value of char" do
    sol = Solution15.new(@test_case)
    expect(sol.getASCII("H")).to eq 72
  end

  it "hashes a word" do
    sol = Solution15.new(@test_case)
    expect(sol.hash("H")).to eq 200
    expect(sol.hash("HASH")).to eq 52
  end

  it "hashes input" do
    sol = Solution15.new(@test_case)
    expect(sol.hashAll.first).to eq 30
    expect(sol.hashAll.last).to eq 231
  end

  it "gets ops list" do
    sol = Solution15.new(@test_case)
    expect(sol.getOps.first).to eq "rn=1"
    expect(sol.getOps.last).to eq "ot=7"
  end

  it "sets up boxes" do
    sol = Solution15.new(@test_case)
    expect(sol.setupBoxes.length).to eq 256
    expect(sol.setupBoxes.last).to eq []
  end

  it "splits op" do
    sol = Solution15.new(@test_case)
    expect(sol.splitOp("rn=1").label).to eq "rn"
    expect(sol.splitOp("rn=1").boxNum).to eq 0
    expect(sol.splitOp("rn=1").op).to eq "="
    expect(sol.splitOp("rn=1").focalLen).to eq 1
    expect(sol.splitOp("zrcvb-").label).to eq "zrcvb"
    expect(sol.splitOp("zrcvb-").boxNum).to eq 55
    expect(sol.splitOp("zrcvb-").focalLen).to eq nil
  end

  it "performs ops" do
    sol = Solution15.new(@test_case)
    expect(sol.performOps[0][0].label).to eq "rn"
    expect(sol.performOps[3].length).to eq 4
  end

  it "calcs vals for one box" do
    sol = Solution15.new(@test_case)
    expect(sol.vals(3, sol.performOps[3])).to eq [28, 40, 72]
  end

  it 'solves example test case (part 1)' do
    sol = Solution15.new(@test_case)
    expect(sol.run).to eq 1320
  end

  it 'solves example test case (part 2)' do
    sol = Solution15.new(@test_case)
    expect(sol.run_2).to eq 145
  end

  it 'solves big test (part 1)' do
    sol = Solution15.new(@big_test)
    expect(sol.run).to eq 516469
  end

  it 'solves big test (part 2)' do
    sol = Solution15.new(@big_test)
    expect(sol.run_2).to eq 221627
  end
end
