require "2023day_03"

RSpec.describe Solution03 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_03_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_03.txt"
  end

  it "determines if char is digit" do
    sol = Solution03.new(@test_case)
    expect(sol.is_digit?("3")).to eq true
    expect(sol.is_digit?(".")).to eq false
  end

  it "gets number and index range" do
    sol = Solution03.new(@test_case)
    res = sol.getNums("467..114..")
    expect(res).to eq [[467, 0, 2], [114, 5, 7]]
    res = sol.getNums("467..115")
    expect(res).to eq [[467, 0, 2], [115, 5, 7]]
    res = sol.getNums("617*......")
    expect(res).to eq [[617, 0, 2]]
    res = sol.getNums(".129*56.....................abc..9.")
    expect(res).to eq [[129, 1, 3], [56, 5, 6], [9, 33, 33]]
  end

  it "determines if there is symbol adjacent" do
    sol = Solution03.new(@test_case)
    res = sol.hasSymbol?([467, 0, 2], "...*......")
    expect(res).to eq true
    res = sol.hasSymbol?([114, 5, 7], "...*......")
    expect(res).to eq false
    res = sol.hasSymbol?([467, 0, 2], "......*......")
    expect(res).to eq false
    res = sol.hasSymbol?([9, 33, 33], "...........364....812*.......*..$...")
    expect(res).to eq true
  end

  it "finds coords of stars" do
    sol = Solution03.new(@test_case)
    expect(sol.findStars).to eq [[1, 3], [4, 3], [8, 5]]
  end

  it "solves example test case (part 1)" do
    sol = Solution03.new(@test_case)
    expect(sol.run).to eq 4361
  end

  it "solves example test case (part 2)" do
    sol = Solution03.new(@test_case)
    expect(sol.run_2).to eq 467835
  end

  it "solves big test (part 1)" do
    sol = Solution03.new(@big_test)
    expect(sol.run).to eq 525181
    # not 484626 (too low) didn't find right index of numbers
    # not 507871 (too low)
    # not 522144 (too low) didn't include numbers at end
  end

  it 'solves big test (part 2)' do
    sol = Solution03.new(@big_test)
    expect(sol.run_2).to eq 84289137
  end
end
