PulseModule = Struct.new(:name, :type, :state, :dest, :inputs, :mostRecentPs)

class Solution20
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def parseModule(m)
    name, dests = m.split(" -> ")
    type = name === "broadcaster" ? name : name[0]
    name = name[1..-1] if name != "broadcaster"
    dests = dests.split(", ")
    ins = name === "broadcaster" ? ["button"] : []
    recentPs = name === "broadcaster" ? { "broadcaster" => false } : {}
    return PulseModule.new(name, type, false, dests, ins, recentPs)
  end

  def pulse(from, p, pModule)
    out = []
    if pModule.type === "broadcaster"
      pModule.dest.each do |d|
        out << [pModule.name, p, d]
      end
    elsif pModule.type === "%"
      if p === "low"
        toSend = pModule.state ? "low" : "high"
        pModule.state = !pModule.state
        pModule.dest.each do |d|
          out << [pModule.name, toSend, d]
        end
      end
    elsif pModule.type === "&"
      pModule.mostRecentPs[from] = p === "high" ? true : false
      allTrue = true
      pModule.mostRecentPs.values.each do |v|
        allTrue = allTrue && v
      end
      toSend = allTrue ? "low" : "high"
      pModule.dest.each do |d|
        out << [pModule.name, toSend, d]
      end
    end
    return out
  end

  def getModules
    out = {}
    @data.each do |line|
      pm = parseModule(line)
      pm.dest.each do |d|
        if out[d] === nil
          out[d] = PulseModule.new(d, nil, false, [], [pm.name], { pm.name => false })
        else
          out[d].inputs << pm.name
          out[d].mostRecentPs[pm.name] = false
        end
      end
      if out[pm.name] === nil
        out[pm.name] = pm
      else
        out[pm.name].dest = pm.dest
        out[pm.name].type = pm.type
      end
    end
    return out
  end

  def pressButton(allMods)
    toSend = [["button", "low", "broadcaster"]]
    lows = 0
    highs = 0
    pointer = 0
    while pointer < toSend.length
      from, p, pModule = toSend[pointer]
      pointer += 1
      pMod = allMods[pModule]
      # puts "#{from} - #{p} -> #{pMod}"
      if p === "low"
        lows += 1
      else
        highs += 1
      end
      res = pulse(from, p, pMod)
      res.each {|r| toSend << r}
    end
    return [lows, highs]
  end

  def run
    allMods = getModules
    lows = 0
    highs = 0
    1000.times do |i|
      l, h = pressButton(allMods)
      lows += l
      highs += h 
      puts "#{i} => #{lows} * #{highs} = #{lows * highs}"
    end
    return lows * highs
  end

  def run_2
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
