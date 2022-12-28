class Solution16
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @graph = {}
    @pList = PointList.new()
    process
  end

  attr_reader :graph, :pList

  def run
    make_edges
    new_stack = []
    # original_opened = []
    # original_opened = ["BB", "DD", "HH", "EE"] # test data
    original_opened = ["BB", "DD", "HH", "EE", "GF", "EK", "AW", "YQ", "XR", "DT", "CD"] # big data
    counter = 0
    max_gas = 0
    @graph["AA"][:gas_when_visited_at_t][30] = 0
    move_stack = next_moves("AA", original_opened).map {|e| Move.new(26, 0, original_opened, e)}
    while move_stack.length > 0 || new_stack.length > 0 do
      visits_to_update = []
      while move_stack.length > 0 do
        cur = move_stack.pop()
        time, gas, opened, cur_loc = cur.execute
        visits_to_update << [cur_loc, gas, time]
        if time >= 0 && gas > max_gas
          max_gas = gas 
          puts "max gas is #{max_gas}, opened: #{opened}"
        end
        follow_this = false #opened.join(",").start_with?("DD,BB,JJ")
        puts "#{cur} #{[time, gas, opened, cur_loc]}" if follow_this
        edges_from_here = next_moves(cur_loc, opened)
        # puts "#{edges_from_here}" if opened.join(",").start_with?("DD")
        edges_from_here.each do |edge|
          good_move = true
          good_move = false if time - edge.cost < 0
          good_move = false if @graph[edge.destination][:gas_when_visited_at_t][time] > gas
          good_move = false if original_opened.include?(edge.destination)
          puts "#{edge}, good?#{good_move}" if follow_this
          new_stack << Move.new(time, gas, [].concat(opened), edge) if good_move
        end
      end
      puts "counter: #{counter}, gas: #{max_gas}, new_stack has #{new_stack.length} moves"
      # puts "visits to update #{visits_to_update}"
      visits_to_update.each do |loc, gas, time|
        @graph[loc][:gas_when_visited_at_t][time] = gas if gas > @graph[loc][:gas_when_visited_at_t][time]
      end
      new_stack.sort_by! {|m| -m.gas_released}
      move_stack.concat(new_stack[0..10000]) if counter < 30
      counter += 1
      new_stack = []
    end
    return max_gas
  end

  def run_2
  end

  def parse(str)
    words = str.split(" ")
    cur = words[1]
    rate = words[4].split("=")[1].to_i
    valves = words[9..-1].join("").split(",")
    @graph[cur] = { rate: rate, valves: valves, gas_when_visited_at_t: Array.new(31, -1) }
  end

  def make_edges
    @data.each do |line|
      parse(line)
    end

    @graph.each do |key, val|
      # puts "#{key} => #{val}"
      val[:valves].each do |dest|
        @pList.add_edge(key, Edge.new(key, dest, 1, 0))
        rate = @graph[dest][:rate]
        @pList.add_edge(key, Edge.new(key, dest, 2, rate)) if rate > 0
      end
    end
    # puts @pList
  end

  def next_moves(valve, opened)
    return @pList.points[valve].select { |m| m.cost == 1 || !opened.include?(m.destination) }
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end

Edge = Struct.new(:name, :destination, :cost, :value)

class Move
  def initialize(time_left, gas_released, open_valves, edge)
    @time_left = time_left
    @gas_released = gas_released
    @open_valves = open_valves
    @edge_to_follow = edge
  end
  attr_reader :gas_released
  def execute
    # puts "executing #{[@time_left, @gas_released, @open_valves]} #{@edge_to_follow}" if @open_valves[0] == "DD"
    t = @time_left - @edge_to_follow.cost
    @open_valves << @edge_to_follow.destination if @edge_to_follow.cost == 2
    return [t, @gas_released + t * @edge_to_follow.value, @open_valves, @edge_to_follow.destination]
  end
end

class PointList
  def initialize
    @points = {}
  end

  attr_reader :points

  def add_edge(cur, edge)
    @points[cur] = [] if @points[cur] == nil
    @points[cur] << edge
  end

  def to_s
    @points.each do |p, edges|
      puts "From #{p} you can go to:"
      edges.each do |edge|
        puts edge
      end
    end
  end
end
