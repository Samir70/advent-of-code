require "2023day_20"

RSpec.describe Solution20 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_20_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_20.txt"
  end

  it "parses a module" do
    sol = Solution20.new(@test_case)
    expect(sol.parseModule("broadcaster -> a, b, c").name).to eq "broadcaster"
    expect(sol.parseModule("broadcaster -> a, b, c").type).to eq "broadcaster"
    expect(sol.parseModule("broadcaster -> a, b, c").state).to eq false
    expect(sol.parseModule("broadcaster -> a, b, c").dest).to eq ["a", "b", "c"]
    expect(sol.parseModule("broadcaster -> a, b, c").inputs).to eq ["button"]
    expect(sol.parseModule("%a -> b").name).to eq "a"
    expect(sol.parseModule("%a -> b").type).to eq "%"
    expect(sol.parseModule("%a -> b").state).to eq false
    expect(sol.parseModule("%a -> b").dest).to eq ["b"]
    expect(sol.parseModule("&inv -> a, b").dest).to eq ["a", "b"]
  end

  it "gets modules" do
    sol = Solution20.new(@test_case)
    expect(sol.getModules["broadcaster"].type).to eq "broadcaster"
    expect(sol.getModules["broadcaster"].state).to eq false
    expect(sol.getModules["broadcaster"].inputs).to eq ["button"]
    expect(sol.getModules["broadcaster"].dest).to eq ["a", "b", "c"]
    expect(sol.getModules["b"].type).to eq "%"
    expect(sol.getModules["b"].inputs).to eq ["broadcaster", "a"]
    expect(sol.getModules["inv"].mostRecentPs).to eq({ "c" => false })
  end

  it "broadcaster responds to a pulse" do
    sol = Solution20.new(@test_case)
    broad = PulseModule.new("broadcaster", "broadcaster", false, ["a", "b", "c"], ["button"], nil)
    expect(sol.pulse("button", "low", broad)).to eq [
      ["broadcaster", "low", "a"], 
      ["broadcaster", "low", "b"], 
      ["broadcaster", "low", "c"]
    ]
  end
  it "flip/flop responds to a pulse" do
    sol = Solution20.new(@test_case)
    a = PulseModule.new("a", "%", false, ["b"], ["broadcaster", "a"], nil)
    expect(sol.pulse("broadcaster", "high", a)).to eq []
    expect(sol.pulse("broadcaster", "low", a)).to eq [["a", "high", "b"]]
    expect(a.state).to eq true
    expect(sol.pulse("broadcaster", "low", a)).to eq [["a", "low", "b"]]
    expect(a.state).to eq false
  end

  it "conjunction responds to a pulse" do
    sol = Solution20.new(@test_case)
    inv = PulseModule.new("inv", "&", false, ["a", "b"], ["broadcaster", "c"], {"c" => false, "broadcaster" => false})
    expect(sol.pulse("c", "high", inv)).to eq [
      ["inv", "high", "a"],
      ["inv", "high", "b"]
    ]
    expect(inv.mostRecentPs["c"]).to eq true
    expect(sol.pulse("broadcaster", "high", inv)).to eq [
      ["inv", "low", "a"],
      ["inv", "low", "b"]
    ]
    expect(inv.mostRecentPs["broadcaster"]).to eq true
  end

  it "counts highs and lows from pressing a button" do
    sol = Solution20.new(@test_case)
    allMods = sol.getModules
    expect(sol.pressButton(allMods)).to eq [8, 4]
  end

  it "solves example test case (part 1)" do
    sol = Solution20.new(@test_case)
    expect(sol.run).to eq 32000000
  end

  it "solves example test case (part 2)" do
    sol = Solution20.new(@test_case)
    expect(sol.run_2).to eq nil
  end

  it "solves big test (part 1)" do
    sol = Solution20.new(@big_test)
    expect(sol.run).to eq 763500168
  end

  it "solves big test (part 2)" do
    sol = Solution20.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
