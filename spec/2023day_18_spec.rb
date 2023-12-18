require '2023day_18'

RSpec.describe Solution18 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/2023day_18_1.txt'
    @big_test = './lib/inputs/big_tests/2023day_18.txt'
  end

  it "splits instructions" do
    sol = Solution18.new(@test_case)
    expect(sol.splitIns.first.dir).to eq "R"
    expect(sol.splitIns[1].dist).to eq 5
    expect(sol.splitIns[2].colour).to eq "#5713f0"
  end

  it "gets a grid" do
    sol = Solution18.new(@test_case)
    expect(sol.getGrid(1).width).to eq 7
    expect(sol.getGrid(1).height).to eq 10
  end

  it "takes a step" do
    sol = Solution18.new(@test_case)
    expect(sol.takeStep([5, 6], [1, 0])).to eq [6, 6]
    expect(sol.takeStep([5, 6], [0, -1])).to eq [5, 5]
  end

  it "finds right number of initial points" do
    sol = Solution18.new(@test_case)
    expect(sol.makeAllPoints(1).size).to eq 38
  end

  it "makes points from instructions" do
    sol = Solution18.new(@test_case)
    instructions = sol.splitIns
    expect(sol.makePoints(0, 0, instructions.first)).to eq [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6]]
  end

  it "converts colour to real instructions" do
    sol = Solution18.new(@test_case)
    expect(sol.convertCol("#70c710")).to eq "R 461937 #70c710"
  end

  it "splits instructions fro part 2" do
    sol = Solution18.new(@test_case)
    expect(sol.splitIns2.first.dir).to eq "R"
    expect(sol.splitIns2.first.dist).to eq 461937
    expect(sol.splitIns2[1].dist).to eq 56407
  end

  it "calcs corners" do
    sol = Solution18.new(@test_case)
    expect(sol.getCorners(1)).to eq [
      [0, 0], [0, 6], [5, 6], [5, 4], [7, 4], [7, 6], [9, 6], 
      [9, 1], [7, 1], [7, 0], [5, 0], [5, 2], [2, 2], [2, 0], [0, 0]
  ]
  end

  it "calcs areas from corners using shoelace" do
    sol = Solution18.new(@test_case)
    corners = [
      [1, 6], [3, 1], [7, 2], [4, 4], [8, 5], [1, 6]
  ].reverse
    expect(sol.shoelace(corners)).to eq 16.5
    corners = [
      [0, 0], [0, 7], [6, 7], [6, 5], [7, 5], [7, 7], [10, 7], 
      [10, 1], [8, 1], [8, 0], [5, 0], [5, 2], [3, 2], [3, 0], [0, 0]
    ]
    expect(sol.shoelace(corners)).to eq 62
  end

  it 'solves example test case (part 1)' do
    sol = Solution18.new(@test_case)
    expect(sol.run(1, 1)).to eq 62
  end
  it 'solves example test case (part 1) using second algorithm' do
    sol = Solution18.new(@test_case)
    expect(sol.run_2(1)).to eq 62
  end
  it 'solves big test (part 1) using second algorithm' do
    sol = Solution18.new(@big_test)
    expect(sol.run_2(1)).to eq 40714
  end

  it 'solves example test case (part 2)' do
    sol = Solution18.new(@test_case)
    expect(sol.run_2(2)).to eq 952408144115
  end

  it 'solves big test (part 1)' do
    sol = Solution18.new(@big_test)
    expect(sol.run(1, 155)).to eq 40714
  end

  it 'solves big test (part 2)' do
    sol = Solution18.new(@big_test)
    expect(sol.run_2(2)).to eq 129849166997110
  end
end
