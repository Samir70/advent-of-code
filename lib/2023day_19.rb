require_relative("../utils/utils.rb")

Rule = Struct.new(:cat, :comp, :num, :dest)
WF = Struct.new(:name, :rules)
Part = Struct.new(:x, :m, :a, :s)
MinMax = Struct.new(:loc, :x, :m, :a, :s)

class Solution19
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def parseRule(rule)
    l, r = rule.split(":")
    return Rule.new(nil, nil, nil, l) if r == nil
    cat = l[0]
    comp = l[1]
    num = l[2..-1].to_i
    return Rule.new(cat, comp, num, r)
  end

  def parseWF(wf)
    name, rules = wf[0..-2].split("{")
    return WF.new(name, rules.split(",").map { |r| parseRule(r) })
  end

  def parsePart(part)
    x, m, a, s = part[1..-2].split(",")
    x, m, a, s = [x, m, a, s].map { |cat| cat.split("=")[1].to_i }
    return Part.new(x, m, a, s)
  end

  def sumPart(part)
    return part.x + part.m + part.a + part.s
  end

  def getWFsAndParts
    wfsRaw, parts = split_by_element(@data, "")
    wfs = {}
    wfsRaw.each do |wf|
      wf = parseWF(wf)
      wfs[wf.name] = wf.rules
    end
    return [
             wfs,
             parts.map { |part| parsePart(part) },
           ]
  end

  def decideDest(rules, part)
    rules.each do |rule|
      return rule.dest if rule.cat === nil
      partVal = part[rule.cat]
      targetVal = rule.num
      passesTest = false
      if rule.comp === "<"
        passesTest = true if partVal < targetVal
      else
        passesTest = true if partVal > targetVal
      end
      return rule.dest if passesTest
    end
  end

  def decideEndJourney(wfs, part)
    loc = "in"

    while loc != "A" && loc != "R"
      loc = decideDest(wfs[loc], part)
    end
    return loc
  end

  def newMinMax(wfs, mm)
    return nil if wfs[mm.loc] === nil
    out = []
    wfs[mm.loc].each do |rule|
      # puts "need to apply", rule, mm
      if rule.cat == nil
        out << MinMax.new(rule.dest, mm.x, mm.m, mm.a, mm.s)
        next
      end
      min, max = mm[rule.cat]
      newMax = [max, rule.num - 1].min
      newMin = [min, rule.num + 1].max
      newMinMax = MinMax.new(rule.dest, mm.x, mm.m, mm.a, mm.s)
      if rule.comp === "<"
        newMinMax[rule.cat] = [min, newMax]
        mm[rule.cat] = [newMax+ 1, max]
      else
        newMinMax[rule.cat] = [newMin, max]
        mm[rule.cat] = [min, newMin - 1]
      end
      out << newMinMax
    end
    return out
  end

  def calcWays(mm)
    ways = 1
    "xmas".split("").each do |cat|
      min, max = mm[cat]
      ways *= max - min + 1
    end
    return ways
  end

  def run
    wfs, parts = getWFsAndParts
    sum = 0
    parts.each do |part|
      dest = decideEndJourney(wfs, part)
      sum += sumPart(part) if dest === "A"
    end
    return sum
  end

  def extractRanges(wfs)
    minMaxList = []
    stack = [MinMax.new("in", [1, 4000], [1, 4000], [1, 4000], [1, 4000])]
    while stack.length > 0
      cur = stack.pop()
      newMMs = newMinMax(wfs, cur)
      newMMs.each do |mm|
        next if mm.loc === "R"
        if mm.loc === "A"
          minMaxList << mm
        else
          stack << mm
        end
      end
    end
    return minMaxList
  end
  
  def run_2
    wfs = getWFsAndParts[0]
    minMaxList = extractRanges(wfs)
    numWays = 0
    minMaxList.each do |mm|
      numWays += calcWays(mm)
    end
    return numWays
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
