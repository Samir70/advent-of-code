require 'day_25'

RSpec.describe Solution25 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/day_25_1.txt'
    @big_test = './lib/inputs/big_tests/day_25.txt'
  end

  it "converts snafu to digits -2..2" do
    expect(snafu_digits("2=")).to eq [2, -2]
    expect(snafu_digits("210-=")).to eq [2, 1, 0, -1, -2]
  end

  it "converts snafu to decimals" do
    expect(snafu2decimal("2=")).to eq 8
    expect(snafu2decimal("1=-0-2")).to eq 1747
  end

  it "converts decimal to base 5" do
    expect(decimal2pental(1747)).to eq "23442"
  end

  it "converts pental to snafu" do
    expect(pental2snafu("400")).to eq "1-00"
    expect(pental2snafu("300")).to eq "1=00"
    expect(pental2snafu("23442")).to eq "1=-0-2"
  end

  it 'solves example test case (part 1)' do
    sol = Solution25.new(@test_case)
    expect(sol.run).to eq "2=-1=0" #4890 in decimal
  end

  it 'solves example test case (part 2)' do
    sol = Solution25.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it 'solves big test (part 1)' do
    sol = Solution25.new(@big_test)
    expect(sol.run).to eq nil
  end

  it 'solves big test (part 2)' do
    sol = Solution25.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
