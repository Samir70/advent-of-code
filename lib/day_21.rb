require_relative "../utils/utils"

class Solution21
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @graph = nil
    process
  end

  attr_reader :data, :graph

  def run
    order = topological_order
    order.each do |vert|
      vertex = @graph.vertices[vert]
      # puts "listening to monkey #{vertex}"
      if vertex[:action].class == Array
        a, op, b = vertex[:action]
        a = @graph.vertices[a][:action]
        b = @graph.vertices[b][:action]
        vertex[:action] = do_op(a, op, b)
        # puts "#{vert} knows his number #{vertex}"
      end
    end
    return @graph.vertices["root"][:action]
  end

  def run_2(humn)
    order = topological_order
    @graph.vertices["humn"][:action] = humn
    order.each do |vert|
      vertex = @graph.vertices[vert]
      # puts "listening to monkey #{vertex}"
      if vertex[:action].class == Array
        a, op, b = vertex[:action]
        a = @graph.vertices[a][:action]
        b = @graph.vertices[b][:action]
        vertex[:action] = do_op(a, op, b)
        # puts "#{vert} knows his number #{vertex}"
      end
    end
  end

  def parse_monkey(str)
    monkey, action = str.split(":")
    prevs = []
    if action.count("*/+-") == 0
      action = action.to_i
    else
      action = action.split(" ")
      action[1] = "//" if action[1] == "/"
      prevs << action[0]
      prevs << action[2]
      # puts "#{monkey}, action: #{action}"
    end
    return { :name => monkey, :action => action, :prevs => prevs, :afters => [] }
  end

  def make_graph
    @graph = Graph.new(@data)
  end

  def topological_order
    make_graph
    @graph.topological_order
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map { |el| parse_monkey(el) }
    file.close
  end
end

class Graph
  def initialize(arr)
    @vertices = {}
    @no_ins = []
    @edge_count = 0
    arr.each do |vertex|
      name = vertex[:name]
      if @vertices[name] == nil
        @vertices[name] = {}
        @vertices[name][:action] = vertex[:action]
        @vertices[name][:prevs] = vertex[:prevs]
        @vertices[name][:afters] = vertex[:afters]
      else
        @vertices[name][:action] = vertex[:action]
        @vertices[name][:prevs] = vertex[:prevs]
      end
      vertex[:prevs].each do |prev|
        @edge_count += 1
        add_afters(prev, name)
      end
      @no_ins << name if vertex[:prevs].length == 0
    end
  end

  def add_afters(v, successor)
    if @vertices[v] == nil
      @vertices[v] = {}
      @vertices[v][:action] = []
      @vertices[v][:prevs] = []
      @vertices[v][:afters] = [successor]
    else
      @vertices[v][:afters] << successor
    end
  end

  def topological_order
    order = []
    while @no_ins.length > 0
      vert = @no_ins.pop
      order << vert
      # puts "#{vert} has empty prevs #{@vertices[vert]}"
      @vertices[vert][:afters].each do |successor|
        # puts "will try to remove #{vert} from #{successor}'s prevs"
        # puts "#{@vertices[successor]}"
        @vertices[successor][:prevs].delete(vert)
        @no_ins << successor if @vertices[successor][:prevs].length == 0
        @edge_count -= 1
      end
    end
    puts "Edgecount is still #{@edge_count}" if @edge_count != 0
    return order
  end

  attr_reader :no_ins, :edge_count, :vertices
end
