require "2023day_07"

RSpec.describe Solution07 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_07_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_07.txt"
  end

  it "finds the type of hand" do
    sol = Solution07.new(@test_case)
    expect(sol.classifyHand("23456")).to eq 0
    expect(sol.classifyHand("A23A4")).to eq 1
    expect(sol.classifyHand("32T3K")).to eq 1
    expect(sol.classifyHand("23432")).to eq 2
    expect(sol.classifyHand("TTT98")).to eq 3
    expect(sol.classifyHand("23332")).to eq 4
    expect(sol.classifyHand("AA8AA")).to eq 5
    expect(sol.classifyHand("AAAAA")).to eq 6
  end
  it "finds the type of hand with jokers" do
    sol = Solution07.new(@test_case)
    expect(sol.classifyHand2("23456")).to eq 0
    expect(sol.classifyHand2("A23A4")).to eq 1
    expect(sol.classifyHand2("32T3K")).to eq 1
    expect(sol.classifyHand2("23432")).to eq 2
    expect(sol.classifyHand2("TTT98")).to eq 3
    expect(sol.classifyHand2("23332")).to eq 4
    expect(sol.classifyHand2("AA8AA")).to eq 5
    expect(sol.classifyHand2("AAAAA")).to eq 6
    expect(sol.classifyHand2("KTJJT")).to eq 5
    expect(sol.classifyHand2("QQQJA")).to eq 5
    expect(sol.classifyHand2("3JJ3J")).to eq 6
    expect(sol.classifyHand2("JJ278")).to eq 3
  end

  it "splits input into cards and bid" do
    sol = Solution07.new(@test_case)
    expect(sol.splitInput("32T3K 765").cards).to eq "32T3K"
    expect(sol.splitInput("32T3K 765").bid).to eq 765
    expect(sol.splitInput("32T3K 765").type).to eq 1
    expect(sol.splitInput("32T3K 765").sortable).to eq "baibl"
    expect(sol.splitInput("32T3K 765").sortable2).to eq "cbjcl"
    expect(sol.splitInput("32T3J 765").sortable2).to eq "cbjca"
  end

  it "sorts cards by value" do
    sol = Solution07.new(@test_case)
    res = sol.sortCards
    expect(res.first.cards).to eq "32T3K"
    expect(res[1].cards).to eq "KTJJT"
    expect(res.last.cards).to eq "QQQJA"
  end
  it "sorts cards with jokers by value" do
    sol = Solution07.new(@test_case)
    res = sol.sortCards2
    expect(res.first.cards).to eq "32T3K"
    expect(res[1].cards).to eq "KK677"
    expect(res.last.cards).to eq "KTJJT"
  end

  it "solves example test case (part 1)" do
    sol = Solution07.new(@test_case)
    expect(sol.run).to eq 6440
  end

  it "solves example test case (part 2)" do
    sol = Solution07.new(@test_case)
    expect(sol.run_2).to eq 5905
  end

  it "solves big test (part 1)" do
    sol = Solution07.new(@big_test)
    expect(sol.run).to eq 251121738
  end

  it "solves big test (part 2)" do
    sol = Solution07.new(@big_test)
    expect(sol.run_2).to eq 251421071
    # 251602241 is too high
    # 251371095 is too low
    # 251421071
  end
end
