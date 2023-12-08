require '2023day_08'

RSpec.describe Solution08 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/2023day_08_1.txt'
    @test_case2 = './lib/inputs/test_cases/2023day_08_2.txt'
    @big_test = './lib/inputs/big_tests/2023day_08.txt'
  end

  it "reads the map" do
    sol = Solution08.new(@test_case)
    expect(sol.getMap.directions).to eq "LLR"
    expect(sol.getMap.nodes["AAA"]).to eq ["BBB", "BBB"]
  end

  it "gets all starting nodes" do
    sol = Solution08.new(@test_case2)
    expect(sol.getStartingNodes(sol.getMap.nodes)).to eq ["11A", "22A"]
  end

  it "finds LCM of two integers" do
    sol = Solution08.new(@test_case)
    expect(sol.lcm(1, 5)).to eq 5
    expect(sol.lcm(2, 3)).to eq 6
    expect(sol.lcm(6, 9)).to eq 18
  end

  it 'solves example test case (part 1)' do
    sol = Solution08.new(@test_case)
    expect(sol.run).to eq 6
  end

  it 'solves example test case (part 2)' do
    sol = Solution08.new(@test_case2)
    expect(sol.run_2).to eq 6
  end

  it 'solves big test (part 1)' do
    sol = Solution08.new(@big_test)
    expect(sol.run).to eq 21251
  end

  it 'solves big test (part 2)' do
    sol = Solution08.new(@big_test)
    expect(sol.run_2).to eq 11678319315857
    # 21251 is too low
  end
end
