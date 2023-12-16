require "2023day_16"
# LightBeam = Struct.new(:row, :col, :dir)

RSpec.describe Solution16 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/2023day_16_1.txt"
    @big_test = "./lib/inputs/big_tests/2023day_16.txt"
    @beam1 = LightBeam.new(0, 0, [0, 1])
    @beam2 = LightBeam.new(0, 0, [1, 0])
  end

  it "loads the grid" do
    sol = Solution16.new(@test_case)
    expect(sol.getGrid.read(1, 2)).to eq "-"
  end

  it "calcs next step of beam" do
    sol = Solution16.new(@test_case)
    expect(sol.takeStep(@beam1)).to eq [0, 1]
    beam = LightBeam.new(5, 3, [-1, 0])
    expect(sol.takeStep(beam)).to eq [4, 3]
  end

  it "updates direction of beam" do
    sol = Solution16.new(@test_case)
    expect(sol.redirect([0, 1], ".")).to eq [[0, 1]]
    expect(sol.redirect([0, 1], "-")).to eq [[0, 1]]
    expect(sol.redirect([0, -1], "-")).to eq [[0, -1]]
    expect(sol.redirect([-1, 0], "-")).to eq [[0, -1], [0, 1]]
    expect(sol.redirect([1, 0], "-")).to eq [[0, -1], [0, 1]]

    expect(sol.redirect([0, -1], "|")).to eq [[-1, 0], [1, 0]]
    expect(sol.redirect([0, 1], "|")).to eq [[-1, 0], [1, 0]]
    expect(sol.redirect([-1, 0], "|")).to eq [[-1, 0]]
    expect(sol.redirect([1, 0], "|")).to eq [[1, 0]]

    expect(sol.redirect([-1, 0], "/")).to eq [[0, 1]]
    expect(sol.redirect([1, 0], "/")).to eq [[0, -1]]
    expect(sol.redirect([0, -1], "/")).to eq [[1, 0]]
    expect(sol.redirect([0, 1], "/")).to eq [[-1, 0]]
    
    expect(sol.redirect([-1, 0], "\\")).to eq [[0, -1]]
    expect(sol.redirect([1, 0], "\\")).to eq [[0, 1]]
    expect(sol.redirect([0, -1], "\\")).to eq [[-1, 0]]
    expect(sol.redirect([0, 1], "\\")).to eq [[1, 0]]
  end

  it "solves example test case (part 1)" do
    sol = Solution16.new(@test_case)
    expect(sol.run(@beam1)).to eq 46
  end

  it "solves example test case (part 2)" do
    sol = Solution16.new(@test_case)
    expect(sol.run_2).to eq 51
  end

  it "solves big test (part 1)" do
    sol = Solution16.new(@big_test)
    expect(sol.run(@beam2)).to eq 8551
    # 12 is wrong -- beam is immedietly reflected down
  end

  it "solves big test (part 2)" do
    sol = Solution16.new(@big_test)
    expect(sol.run_2).to eq 8754
  end
end
