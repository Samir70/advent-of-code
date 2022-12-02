require "01_counting_calories"

RSpec.describe CountCals do
  it "solves example test case" do
    cc = CountCals.new("./lib/inputs/01_test_1.txt")
    expect(cc.run).to eq 24000
  end
  it "solves example test case for top three elves" do
    cc = CountCals.new("./lib/inputs/01_test_1.txt")
    expect(cc.run_2).to eq 45000
  end
  it "solves big test case for best elf" do
    cc = CountCals.new("./lib/inputs/01_big_test.txt")
    # 763987 was too high
    expect(cc.run).to eq 69528
  end
  it "solves example test case for top three elves" do
    cc = CountCals.new("./lib/inputs/01_big_test.txt")
    expect(cc.run_2).to eq 45000
  end
end
