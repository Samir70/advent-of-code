Op = Struct.new(:label, :boxNum, :op, :focalLen)

class Solution15
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getASCII(c)
    return c.length === 1 ? c.ord() : nil
  end

  def hash(str)
    out = 0
    str.split("").each do |c|
      out += getASCII(c)
      out *= 17
      out %= 256
    end
    return out
  end

  def hashAll
    return getOps.map { |line| hash(line) }
  end

  def getOps
    return @data[0].split(",")
  end

  def splitOp(op)
    if op[op.length - 1] === "-"
      parts = op.split("-")
      return Op.new(parts[0], hash(parts[0]), "-", nil)
    else
      parts = op.split("=")
      return Op.new(parts[0], hash(parts[0]), "=", parts[1].to_i)
    end
  end

  def setupBoxes
    boxes = []
    256.times do |i|
      boxes << []
    end
    return boxes
  end

  def performOps
    boxes = setupBoxes
    ops = getOps.map { |op| splitOp(op) }
    ops.each do |op|
      # puts op
      if op.op === "="
        i = boxes[op.boxNum].index {|el| el.label === op.label}
        # puts "found op in box at #{i == nil ? "nil" : i}"
        if i == nil
          boxes[op.boxNum] << op
        else
          boxes[op.boxNum][i].focalLen = op.focalLen
        end
      else 
        # puts "remove #{op.label}"
        boxes[op.boxNum].each.with_index do |el, i|
          el.label = "removed" if el.label === op.label
          # puts "box: #{boxes[op.boxNum]}"
        end
      end
    end
    # boxes.each.with_index do |b, i|
    #   puts i if b.length > 0
    #   puts b if b.length > 0
    # end
    return boxes
  end

  def vals(bNum, box)
    out = []
    place = 1
    box.each do |op|
      next if op.label === "removed"
      out << (bNum + 1) * place * op.focalLen
      place += 1
    end
    return out
  end

  def run
    # puts @data.length
    return hashAll.sum
  end

  def run_2
    boxes = performOps
    sum = 0
    boxes.each.with_index do |box, i|
      sum += vals(i, box).sum
    end
    return sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
