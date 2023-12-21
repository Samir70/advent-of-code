require '2023day_21'

RSpec.describe Solution21 do
  before(:each) do
    @test_case = './lib/inputs/test_cases/2023day_21_1.txt'
    @big_test = './lib/inputs/big_tests/2023day_21.txt'
  end

  it "gets the grid" do
    sol = Solution21.new(@test_case)
    expect(sol.getGrid.read(2, 3)).to eq "#"
  end
  it "finds the start" do
    sol = Solution21.new(@test_case)
    expect(sol.findStart(sol.getGrid)).to eq [5, 5]
  end
  it "takes a step" do
    sol = Solution21.new(@test_case)
    grid = sol.getGrid
    expect(sol.takeStep(grid, [[5, 5]])).to eq [[4, 5], [5, 4]]
    expect(sol.takeStep(grid, [[4, 5], [5, 4]])).to eq [[3, 5], [5, 5], [6, 4], [5, 3]]
  end

  it 'solves example test case (part 1)' do
    sol = Solution21.new(@test_case)
    expect(sol.run(6)).to eq 16
  end

  it 'solves example test case (part 2)' do
    sol = Solution21.new(@test_case)
    expect(sol.run_2(6)).to eq 16
    expect(sol.run_2(10)).to eq 50
    expect(sol.run_2(50)).to eq 1594
    expect(sol.run_2(100)).to eq 6536
    expect(sol.run_2(500)).to eq 167004
    expect(sol.run_2(1000)).to eq 668697
    expect(sol.run_2(5000)).to eq 16733044
  end

  it 'solves big test (part 1)' do
    sol = Solution21.new(@big_test)
    expect(sol.run(64)).to eq 3615
  end

  it 'solves big test (part 2)' do
    sol = Solution21.new(@big_test)
    expect(sol.run_2).to eq nil
  end
end
