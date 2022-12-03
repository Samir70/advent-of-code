require "day_01"

RSpec.describe CountCals do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_01_1.txt"
    @big_test = "./lib/inputs/big_tests/day_01.txt"
  end
  it "solves example test case" do
    cc = CountCals.new(@test_case)
    expect(cc.run).to eq 24000
  end
  it "solves example test case for top three elves" do
    cc = CountCals.new(@test_case)
    expect(cc.run_2).to eq 45000
  end
  it "solves big test case for best elf" do
    cc = CountCals.new(@big_test)
    # 763987 was too high
    expect(cc.run).to eq 69528
  end
  it "solves example test case for top three elves" do
    cc = CountCals.new(@big_test)
    expect(cc.run_2).to eq 206152
  end
end
