require "day_17"

RSpec.describe Solution17 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_17_1.txt"
    @big_test = "./lib/inputs/big_tests/day_17.txt"
  end

  it "finds the best ans" do
    pa = PossAns.new()
    pa.add(5)
    expect(pa.best_ans).to eq 5
    pa.add(2)
    expect(pa.best_ans).to eq 2
    pa.add(1)
    pa.add(1)
    expect(pa.best_ans).to eq 1
  end

  it "initialises the tetris board" do
    tb = TetrisBoard.new()
    expect(tb.board).to eq ["+-------+"]
    expect(tb.sprite_rows).to eq []
  end

  it "adds sprite0 to the tetris board" do
    tb = TetrisBoard.new()
    tb.add(Sprites[0])
    expect(tb.board.length).to eq 5
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|..@@@@.|",
                           ]
    expect(tb.sprite_rows).to eq [4]
  end
  it "adds sprite2 to the tetris board" do
    tb = TetrisBoard.new()
    tb.add(Sprites[2])
    expect(tb.board.length).to eq 7
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|..@@@..|",
                             "|....@..|",
                             "|....@..|",
                           ]
    expect(tb.sprite_rows).to eq [4, 5, 6]
  end

  it "shifts sprite left" do
    tb = TetrisBoard.new()
    tb.add(Sprites[2])
    expect(tb.left).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|.@@@...|",
                             "|...@...|",
                             "|...@...|",
                           ]
    expect(tb.left).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|@@@....|",
                             "|..@....|",
                             "|..@....|",
                           ]
    expect(tb.left).to eq false
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|@@@....|",
                             "|..@....|",
                             "|..@....|",
                           ]
    expect(tb.board.length).to eq 7
    expect(tb.sprite_rows).to eq [4, 5, 6]
  end
  it "shifts sprite right" do
    tb = TetrisBoard.new()
    tb.add(Sprites[2])
    expect(tb.right).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|...@@@.|",
                             "|.....@.|",
                             "|.....@.|",
                           ]
    expect(tb.right).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|....@@@|",
                             "|......@|",
                             "|......@|",
                           ]
    expect(tb.right).to eq false
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|.......|",
                             "|....@@@|",
                             "|......@|",
                             "|......@|",
                           ]
    expect(tb.board.length).to eq 7
    expect(tb.sprite_rows).to eq [4, 5, 6]
  end
  it "shifts sprite down" do
    tb = TetrisBoard.new()
    tb.add(Sprites[2])
    expect(tb.down).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|.......|",
                             "|..@@@..|",
                             "|....@..|",
                             "|....@..|",
                           ]
    expect(tb.sprite_rows).to eq [3, 4, 5]
    expect(tb.down).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|.......|",
                             "|..@@@..|",
                             "|....@..|",
                             "|....@..|",
                           ]
    expect(tb.sprite_rows).to eq [2, 3, 4]
    expect(tb.down).to eq true
    expect(tb.board).to eq [
                             "+-------+",
                             "|..@@@..|",
                             "|....@..|",
                             "|....@..|",
                           ]
    expect(tb.sprite_rows).to eq [1, 2, 3]
    expect(tb.down).to eq false
    expect(tb.board).to eq [
                             "+-------+",
                             "|..###..|",
                             "|....#..|",
                             "|....#..|",
                           ]
    expect(tb.board.length).to eq 4
    expect(tb.sprite_rows).to eq [1, 2, 3]
  end

  it "solves example test case (part 1)" do
    sol = Solution17.new(@test_case)
    expect(sol.run(2022)).to eq 3068
  end
  it "solves big test (part 1)" do
    sol = Solution17.new(@big_test)
    expect(sol.run(2022)).to eq 3137
  end

  it "solves example test case (part 2)" do
    sol = Solution17.new(@test_case)
    expect(sol.run(1000000000000)).to eq 1514285714288
  end
  it "solves big test (part 2)" do
    sol = Solution17.new(@big_test)
    expect(sol.run_4(1000000000000)).to eq 1564705882327
    # 4694077332400 is too high
    # 1564 744 822 081 is too high
    # 1564 699 417 112 is too low
    # 1564 705 882 327
  end
end
