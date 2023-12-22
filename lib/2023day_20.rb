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

  def pressButton(allMods, count)
    toSend = [["button", "low", "broadcaster"]]
    lows = 0
    highs = 0
    pointer = 0
    whoSentHighToDH = []
    while pointer < toSend.length
      from, p, pModule = toSend[pointer]
      pointer += 1
      # puts "#{[from, p, pModule]}" if pModule === "rx"
      puts "count: #{count} => #{[from, p, pModule]}" if pModule === "dh" && p === "high"
      return "rx got low" if p === "low" && pModule === "rx"
      whoSentHighToDH << from if p === "high" && pModule === "dh"
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
    return [lows, highs, whoSentHighToDH]
  end

  def run
    allMods = getModules
    lows = 0
    highs = 0
    1000.times do |i|
      l, h = pressButton(allMods, 0)
      lows += l
      highs += h 
      # puts "#{i} => #{lows} * #{highs} = #{lows * highs}"
    end
    return lows * highs
  end

  def countTrues(pm)
    count = 0
    pm.mostRecentPs.values.each {|v| count += 1 if v}
    return count
  end

  def run_2
    count = 0
    allMods = getModules
    timesTilSendHigh = {
      "tr" => 0, 
      "xm" => 0, 
      "dr" => 0, 
      "nh" => 0, 
    }
    while true
      count += 1
      res = pressButton(allMods, count)
      # puts count if count % 1000 === 0
      if res[2].length > 0
        timesTilSendHigh[res[2][0]] = count if timesTilSendHigh[res[2][0]] == 0
        prod = 1
        timesTilSendHigh.values.each {|v| prod *= v}
        return prod if prod > 0
      end
      # we get: 
      # count: 3739 => ["tr", "high", "dh"]
      # count: 3761 => ["xm", "high", "dh"]
      # count: 3797 => ["dr", "high", "dh"]
      # count: 3889 => ["nh", "high", "dh"]
      # all counts are prime, LCM = 207652583562007
      return count if res === "rx got low" # takes way too long!!!!!!!!!
    end
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
