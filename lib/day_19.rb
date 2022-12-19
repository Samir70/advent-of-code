class Solution19
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run(minutes)
    geodes = []
    @data.each_with_index do |bp_str, bp_id|
      bp = parseBP(bp_str)
      # puts bp
      state = [[1, 0, 0, 0], [0, 0, 0, 0]]
      state_stack = []
      new_stack = [state]
      time = 0
      max_geo = 0
      while new_stack.length > 0 && time < minutes
        time += 1
        state_stack = [].concat(new_stack[0..1000])
        new_stack = []
        while state_stack.length > 0
          robots, materials = state_stack.pop()
          options = bp.can_make(materials)
          materials = add_vector(robots, materials)
          max_geo = materials[3] if materials[3] > max_geo
          if options[3]
            new_stack << [add_vector(robots, [0, 0, 0, 1]), subtract_vector(materials, bp.geode)]
            # elsif options[2]
            #   new_stack << [robots, materials]
            # elsif options[1]
            #   new_stack << [add_vector(robots, [0, 1, 0, 0]), subtract_vector(materials, bp.clay)]
            #   new_stack << [robots, materials]
            # elsif options[0] && robots[0] < 4
            #   new_stack << [robots, materials]
          else
            new_stack << [add_vector(robots, [0, 0, 1, 0]), subtract_vector(materials, bp.obsidian)] if options[2]
            new_stack << [add_vector(robots, [0, 1, 0, 0]), subtract_vector(materials, bp.clay)] if options[1]
            new_stack << [add_vector(robots, [1, 0, 0, 0]), subtract_vector(materials, bp.ore)] if options[0]
            new_stack << [robots, materials]
          end
        end
        # puts "time: #{time}"
        new_stack.sort_by! { |el| -score(el[0], minutes - time, el[1], bp.costs) }
        # puts "score of first: #{score(new_stack.first[0], minutes - time, new_stack.first[1], bp.costs)}"
        # puts "score of last: #{score(new_stack.last[0], minutes - time, new_stack.last[1], bp.costs)}"
        # puts "stack: #{new_stack.length}"
      end
      puts "for bp #{bp_id + 1} max_geo was #{max_geo}"
      geodes << max_geo #* (bp_id + 1)
    end
    return geodes
  end

  def qual_levels(arr)
    out = 0
    arr.each_with_index { |el, i| out += el * (i + 1) }
    return out
  end

  def score(robots, time, materials, costs)
    def s(robots, materials, time, t)
      return robots[t] * time + materials[t]
    end

    # for each type: score[type] = num_of_machines[type] * time_left + inventory_count[type]

    #   score = cost_of_geode_in_obsidian * cost_of_obsidian_in_clay * cost_of_clay_in_ore * score[geode]
    #   + cost_of_obsidian_in_clay * cost_of_clay_in_ore * score[obsidian]
    #   + cost_of_clay_in_ore * score[clay]
    #   + score[ore]
    return (costs[3][2] * costs[2][1] * costs[1][0] * s(robots, materials, time, 3)) + (costs[2][1] * costs[1][0] * s(robots, materials, time, 2)) + (costs[1][0] * s(robots, materials, time, 1)) + s(robots, materials, time, 0)
  end

  def run_2(minutes)
    @data = @data[0..2]
    return run(minutes)
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
    @ore = costs[0]
    @clay = costs[1]
    @obsidian = costs[2]
    @geode = costs[3]
    @costs = costs
  end

  attr_reader :ore, :clay, :obsidian, :geode, :costs

  def can_make(materials) # materials is array [ore, clay, obsidian]
    return [@ore, @clay, @obsidian, @geode].map do |robot|
             robot[0] <= materials[0] && robot[1] <= materials[1] && robot[2] <= materials[2]
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
