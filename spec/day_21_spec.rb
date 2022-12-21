require "day_21"

RSpec.describe Solution21 do
  before(:each) do
    @test_case = "./lib/inputs/test_cases/day_21_1.txt"
    @big_test = "./lib/inputs/big_tests/day_21.txt"
  end

  it "parses monkeys" do
    sol = Solution21.new(@test_case)
    expect(sol.data[0]).to eq({ :name => "root", :action => ["pppw", "+", "sjmn"], :prevs => ["pppw", "sjmn"], :afters => [] })
    expect(sol.data[1]).to eq({ :name => "dbpl", :action => 5, :prevs => [], :afters => [] })
  end

  it "can list the monkeys with no dependents" do
    sol = Solution21.new(@test_case)
    sol.make_graph
    expect(sol.graph.no_ins).to eq ["dbpl", "zczc", "dvpt", "lfqf", "humn", "ljgn", "sllz", "hmdt"]
    expect(sol.graph.edge_count).to eq 14
    expect(sol.graph.vertices["dbpl"][:afters]).to eq ["sjmn"]
    expect(sol.graph.vertices["hmdt"][:afters]).to eq ["drzm"]
  end

  it "finds a topological order for graph" do
    sol = Solution21.new(@test_case)
    expect(sol.topological_order).to eq ["hmdt", "sllz", "ljgn", "humn", "lfqf", "dvpt", "ptdq", "lgvd", "cczh", "pppw", "zczc", "drzm", "dbpl", "sjmn", "root"]
  end

  it "solves example test case (part 1)" do
    sol = Solution21.new(@test_case)
    expect(sol.run).to eq 152
  end

  it "solves example test case (part 2)" do
    # root: pppw + sjmn
    left = 0
    right = 1000
    mid = 0
    while left < right
      mid = left + (right - left) / 2
      sol = Solution21.new(@test_case)
      sol.run_2(mid)
      pppw = sol.graph.vertices["pppw"][:action]
      sjmn = sol.graph.vertices["sjmn"][:action]
      # puts "humn: #{mid}, pppw: #{pppw}, sjmn: #{sjmn}"
      if pppw == sjmn
        left = right + 1
      elsif pppw < sjmn
        left = mid + 1
      else
        right = mid - 1
      end
    end
    expect(mid).to eq 301
  end

  it "solves big test (part 1)" do
    sol = Solution21.new(@big_test)
    expect(sol.run).to eq 291425799367130
  end

  it "solves big test (part 2)" do
    left = 0
    right = 200860392214380
    # right = 3219579395610
    mid = 0
    pgtp = 0
    vrvh = 0
    while left < right
      mid = left + (right - left) / 2
      sol = Solution21.new(@big_test)
      sol.run_2(mid)
      pgtp = sol.graph.vertices["pgtp"][:action]
      vrvh = sol.graph.vertices["vrvh"][:action]
      # puts "humn: #{mid}, pgpt: #{pgtp}, vrvh: #{vrvh}"
      if pgtp.to_i == vrvh.to_i
        left = right + 1
      elsif pgtp > vrvh
        left = mid + 1
      else
        right = mid 
      end
    end
    mid = nil if pgtp.to_i != vrvh.to_i
    expect(mid).to eq 3219579395609
    # 3219579395610 is too big
  end
end
