require "2023day_05"

RSpec.describe Solution05 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_05_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_05.txt"
  end

  it "processes a section" do
    sol = Solution05.new(@test_case)
    res = sol.processSection(["seed-to-soil map:", "50 98 2", "52 50 48"])
    expect(res).to eq [[50, 98, 2], [52, 50, 48]]
  end

  it "unpacks maps" do
    sol = Solution05.new(@test_case)
    res = sol.getMaps
    expect(res.seed2soil).to eq [[50, 98, 2], [52, 50, 48]]
    expect(res.humid2loc).to eq [[60, 56, 37], [56, 93, 4]]
  end

  it "calcs dest given source and a map" do
    sol = Solution05.new(@test_case)
    expect(sol.followMap([50, 98, 2], 98)).to eq 50
    expect(sol.followMap([50, 98, 2], 99)).to eq 51
    expect(sol.followMap([52, 50, 48], 50)).to eq 52
    expect(sol.followMap([52, 50, 48], 97)).to eq 99
    expect(sol.followMap([52, 50, 48], 10)).to eq 10
    expect(sol.followMap([50, 98, 2], 10)).to eq 10
  end

  it "calcs dest given source and a list of maps" do
    sol = Solution05.new(@test_case)
    expect(sol.followMaps([[50, 98, 2], [52, 50, 48]], 98)).to eq 50
    expect(sol.followMaps([[50, 98, 2], [52, 50, 48]], 99)).to eq 51
    expect(sol.followMaps([[50, 98, 2], [52, 50, 48]], 55)).to eq 57
    expect(sol.followMaps([[50, 98, 2], [52, 50, 48]], 14)).to eq 14
  end

  it "pairs up numbers in list" do
    sol = Solution05.new(@test_case)
    expect(sol.getPairs([79, 14, 55, 13])).to eq [[79, 14], [55, 13]]
  end

  it "converts a map to an interval" do
    sol = Solution05.new(@test_case)
    expect(sol.map2interval([50, 98, 2])).to eq [98, 99, -48]
    expect(sol.map2interval([52, 50, 48])).to eq [50, 97, 2]
  end

  it "makes range out of intervalDiff" do
    sol = Solution05.new(@test_case)
    expect(sol.makeRange([79, 92, 2])).to eq [81, 94]
  end

  it "converts pair to range" do
    sol = Solution05.new(@test_case)
    expect(sol.pair2range([79, 14])).to eq [79, 92]
    expect(sol.pair2range([55, 13])).to eq [55, 67]
  end

  it "processes maps and range into new ranges" do
    sol = Solution05.new(@test_case)
    res = sol.processRange([[50, 97, 2], [98, 99, -48]], 45, 100)
    expect(res).to eq [[45, 49], [52, 99], [50, 51], [100, 100]]
    res = sol.processRange([[50, 97, 2], [98, 99, -48]], 45, 102)
    expect(res).to eq [[45, 49], [52, 99], [50, 51], [100, 102]]
  end

  it "solves example test case (part 1)" do
    sol = Solution05.new(@test_case)
    expect(sol.run).to eq 35
  end

  it "solves example test case (part 2)" do
    sol = Solution05.new(@test_case)
    expect(sol.run_2).to eq 46
  end

  it "solves big test (part 1)" do
    sol = Solution05.new(@big_test)
    expect(sol.run).to eq 31599214
  end

  it "solves big test (part 2)" do
    sol = Solution05.new(@big_test)
    expect(sol.run_2).to eq 20358599
  end
end
