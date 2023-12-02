require "2023day_02"

RSpec.describe Solution02 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_02_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_02.txt"
  end

  it "splits a grab into rbg object" do
    sol = Solution02.new(@test_case)
    res = sol.rgb("3 blue, 4 red")
    expect(res[:red]).to eq 4
    expect(res[:green]).to eq nil
    expect(res[:blue]).to eq 3
    res = sol.rgb("1 red, 2 green, 6 blue")
    expect(res[:red]).to eq 1
    expect(res[:green]).to eq 2
    expect(res[:blue]).to eq 6
  end

  it "finds the max of each colour" do
    sol = Solution02.new(@test_case)
    res = sol.findMax([{ :blue => 3, :red => 4 }, { :blue => 6, :green => 2, :red => 1 }, { :green => 2 }])
    expect(res).to eq [4, 2, 6]
  end

  it "splits a game into id and max of rgb" do
    sol = Solution02.new(@test_case)
    res = sol.splitGame("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    expect(res[:id]).to eq 1
    expect(res[:max]).to eq [4, 2, 6]
    res = sol.splitGame("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")
    expect(res[:id]).to eq 2
    expect(res[:max]).to eq [1, 3, 4]
  end

  it "finds the power of a game" do
    sol = Solution02.new(@test_case)
    res = sol.power("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")
    expect(res).to eq 12
  end

  it "solves example test case (part 1)" do
    sol = Solution02.new(@test_case)
    expect(sol.run(12, 13, 14)).to eq 8
  end

  it "solves example test case (part 2)" do
    sol = Solution02.new(@test_case)
    expect(sol.run_2).to eq 2286
  end

  it "solves big test (part 1)" do
    sol = Solution02.new(@big_test)
    expect(sol.run(12, 13, 14)).to eq 2204
  end

  it "solves big test (part 2)" do
    sol = Solution02.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
