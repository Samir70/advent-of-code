require "2023day_19"

RSpec.describe Solution19 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_19_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_19.txt"
  end

  it "parses a rule" do
    sol = Solution19.new(@test_case)
    expect(sol.parseRule("a<2006:qkq").cat).to eq "a"
    expect(sol.parseRule("a<2006:qkq").comp).to eq "<"
    expect(sol.parseRule("a<2006:qkq").num).to eq 2006
    expect(sol.parseRule("a<2006:qkq").dest).to eq "qkq"
    expect(sol.parseRule("rfg").cat).to eq nil
    expect(sol.parseRule("rfg").comp).to eq nil
    expect(sol.parseRule("rfg").num).to eq nil
    expect(sol.parseRule("rfg").dest).to eq "rfg"
  end

  it "parses a workflow" do
    sol = Solution19.new(@test_case)
    expect(sol.parseWF("px{a<2006:qkq,m>2090:A,rfg}").name).to eq "px"
    expect(sol.parseWF("px{a<2006:qkq,m>2090:A,rfg}").rules.first.num).to eq 2006
    expect(sol.parseWF("px{a<2006:qkq,m>2090:A,rfg}").rules.last.dest).to eq "rfg"
  end
  it "parses a part" do
    sol = Solution19.new(@test_case)
    expect(sol.parsePart("{x=787,m=2655,a=1222,s=2876}").x).to eq 787
    expect(sol.parsePart("{x=787,m=2655,a=1222,s=2876}").m).to eq 2655
    expect(sol.parsePart("{x=787,m=2655,a=1222,s=2876}").a).to eq 1222
    expect(sol.parsePart("{x=787,m=2655,a=1222,s=2876}").s).to eq 2876
  end
  it "sums a part" do
    sol = Solution19.new(@test_case)
    part = sol.parsePart("{x=787,m=2655,a=1222,s=2876}")
    expect(sol.sumPart(part)).to eq 7540
  end

  it "gets workflows and parts" do
    sol = Solution19.new(@test_case)
    wfs, parts = sol.getWFsAndParts
    expect(wfs["px"].first.num).to eq 2006
    expect(parts.first.x).to eq 787
  end

  it "decides a destination" do
    sol = Solution19.new(@test_case)
    rules = sol.parseWF("px{a<2006:qkq,m>2090:A,rfg}").rules
    part = sol.parsePart("{x=787,m=2655,a=1222,s=2876}")
    expect(sol.decideDest(rules, part)).to eq "qkq"
    part = sol.parsePart("{x=787,m=2655,a=3000,s=2876}")
    expect(sol.decideDest(rules, part)).to eq "A"
    part = sol.parsePart("{x=787,m=5,a=3000,s=2876}")
    expect(sol.decideDest(rules, part)).to eq "rfg"
  end
  it "decides the end of journey for part" do
    sol = Solution19.new(@test_case)
    wfs = sol.getWFsAndParts[0]
    part = sol.parsePart("{x=787,m=2655,a=1222,s=2876}")
    expect(sol.decideEndJourney(wfs, part)).to eq "A"
  end
  it "calcs change to minMaxs after following rule" do
    sol = Solution19.new(@test_case)
    wfs = sol.getWFsAndParts[0]
    minmax = MinMax.new("in", [1, 4000], [1, 4000], [1, 4000], [1, 4000])
    expect(sol.newMinMax(wfs, minmax)).to eq [
                                               MinMax.new("px", [1, 4000], [1, 4000], [1, 4000], [1, 1350]),
                                               MinMax.new("qqz", [1, 4000], [1, 4000], [1, 4000], [1351, 4000]),
                                             ]
  end

  it "cals numWays for a MinMax" do
    sol = Solution19.new(@test_case)
    minmax = MinMax.new("A", [1, 4000], [839, 1800], [1, 4000], [1, 4000])
    expect(sol.calcWays(minmax)).to eq 4000 * 962 * 4000 * 4000
  end

  it "extracts x ranges from a minmaxList" do
    sol = Solution19.new(@test_case)
    wfs = sol.getWFsAndParts[0]
    # originally built up in stages, but might as well test all at once
    minMaxList = [
      MinMax.new("A", [1, 4000], [839, 1800], [1, 4000], [1351, 2770]),
      MinMax.new("A", [1, 4000], [1, 838], [1, 1716], [1351, 2770]),
      MinMax.new("A", [1, 4000], [1, 4000], [1, 4000], [3449, 4000]),
      MinMax.new("A", [1, 4000], [1549, 4000], [1, 4000], [2771, 3448]),
      MinMax.new("A", [1, 4000], [1, 1548], [1, 4000], [2771, 3448]),
      MinMax.new("A", [1, 4000], [2091, 4000], [2006, 4000], [1, 1350]),
      MinMax.new("A", [1, 2440], [1, 2090], [2006, 4000], [537, 1350]),
      MinMax.new("A", [1, 1415], [1, 4000], [1, 2005], [1, 1350]),
      MinMax.new("A", [2663, 4000], [1, 4000], [1, 2005], [1, 1350]),
    ]
    expect(sol.extractRanges(wfs)).to eq minMaxList
  end

  it "solves example test case (part 1)" do
    sol = Solution19.new(@test_case)
    expect(sol.run).to eq 19114
  end

  it "solves example test case (part 2)" do
    sol = Solution19.new(@test_case)
    expect(sol.run_2).to eq 167409079868000
  end

  it "solves big test (part 1)" do
    sol = Solution19.new(@big_test)
    expect(sol.run).to eq 386787
  end

  it "solves big test (part 2)" do
    sol = Solution19.new(@big_test)
    expect(sol.run_2).to eq 131029523269531
  end
end
