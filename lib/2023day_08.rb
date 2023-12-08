MapNodes = Struct.new(:directions, :nodes)

class Solution08
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getMap
    n = @data.length
    dirs = @data[0]
    nodes = {}
    (2...n).each do |i|
      key, val = @data[i].split(" = ")
      val = val[1..-2].split(", ")
      # puts "#{key} => #{val}"
      nodes[key] = val
    end
    return MapNodes.new(dirs, nodes)
  end

  def getStartingNodes(nodeList)
    return nodeList.keys().filter { |k| k[2] == "A" }
  end

  def lcm(a, b)
    m = [a, b].max
    other = [a, b].min
    out = m
    while out % other != 0
      out += m
    end
    return out
  end

  def run
    lr = { "L" => 0, "R" => 1 }
    count = 0
    i = 0
    loc = "AAA"
    mapDetails = getMap
    dirs = mapDetails.directions
    nodes = mapDetails.nodes
    # puts dirs, nodes
    while loc != "ZZZ"
      d = lr[dirs[i]]
      loc = nodes[loc][d]
      count += 1
      i += 1
      i = 0 if i >= dirs.length
    end
    return count
  end

  def run_2
    lr = { "L" => 0, "R" => 1 }
    mapDetails = getMap
    dirs = mapDetails.directions
    nodes = mapDetails.nodes
    starters = getStartingNodes(nodes)
    # puts dirs, nodes, starters 
    out = 1
    starters.each do |loc|
      count = 0
      i = 0
      # puts "#{loc} finished in ..."
      while loc[2] != "Z"
        d = lr[dirs[i]]
        loc = nodes[loc][d]
        count += 1
        i += 1
        i = 0 if i >= dirs.length
      end
      out = lcm(count, out)
      # puts "#{count} steps"
    end

    return out
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
