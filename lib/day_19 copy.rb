class Solution19
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run(minutes)
    scores = []
    orders = make_orders("", 10)
    puts orders.length
    @data.each_with_index do |bp_str, idx|
      bp = parseBP(bp_str)
      max_geos = 0
      order_for_max = ""
      orders.each do |order|
        bp.reset
        bp.make_robots(order.split("").map(&:to_i), 25)
        geos = bp.materials[3]
        if geos > max_geos
          max_geos = geos 
          order_for_max = order
        end
      end
      puts "for bp#{idx + 1} found max geos was #{max_geos} with order #{order_for_max}"
      scores << (idx + 1) * max_geos
    end
    return scores.sum
  end

  def run_2
  end

  def parseBP(str)
    BluePrint.new(str.split("Each")[1..-1].map { |el| parse_costs(el.split("costs")[1]) })
  end

  def parse_costs(str)
    pos = { "ore" => 0, "ore." => 0, "clay." => 1, "obsidian." => 2 }
    words = str.split(" ")
    out = [0, 0, 0]
    # puts "#{words} => #{pos[words[1]]}"
    out[pos[words[1]]] += words[0].to_i
    out[pos[words[4]]] += words[3].to_i if words.length > 2
    return out
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end

class BluePrint
  def initialize(costs)
    @robots = [1, 0, 0, 0]
    @materials = [0, 0, 0, 0]
    @ore = costs[0]
    @clay = costs[1]
    @obsidian = costs[2]
    @geode = costs[3]
    @costs = costs
  end

  attr_reader :ore, :clay, :obsidian, :geode, :robots, :materials

  def reset
    @robots = [1, 0, 0, 0]
    @materials = [0, 0, 0, 0]
    @ore = @costs[0]
    @clay = @costs[1]
    @obsidian = @costs[2]
    @geode = @costs[3]
  end

  def can_make(robot_type) # materials is array [ore, clay, obsidian]
    robot = [@ore, @clay, @obsidian, @geode][robot_type]
    return robot[0] <= @materials[0] && robot[1] <= @materials[1] && robot[2] <= @materials[2]
  end

  def make_robots(to_make, mins)  
    time = 0
    making_idx = 0
    while time < mins do
      time += 1
      robot = to_make[making_idx]
      if robot != nil && can_make(robot)
        @materials = add_vector(@materials, @robots)
        @robots[robot] += 1
        @materials = subtract_vector(@materials, @costs[robot])
        making_idx += 1
      else
        @materials = add_vector(@materials, @robots)
      end
      # puts "time: #{time}, robots: #{@robots}, materials: #{@materials}"
    end
  end
end

def add_vector(a, b)
  len = a.length
  b << 0 if b.length < len
  puts "#{a} and #{b} can't be added" if b.length != len
  out = []
  len.times do |i|
    out << a[i] + b[i]
  end
  return out
end
def subtract_vector(a, b)
  len = a.length
  b << 0 if b.length < len
  puts "#{a} and #{b} can't be added" if b.length != len
  out = []
  len.times do |i|
    out << a[i] - b[i]
  end
  return out
end
def make_orders(str, len)
  return [str] if str.length == len
  out = []
  out.concat(make_orders(str+"0", len))
  out.concat(make_orders(str+"1", len))
  out.concat(make_orders(str+"2", len)) if str.include?("1")
  out.concat(make_orders(str+"3", len)) if str.include?("2")
  return out
end