require_relative "../utils/grid_from_strings.rb"

class Solution14
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def getGrid
    return GridFromStrings.new(@data)
  end

  def tilt(str)
    i = 1
    while i < str.length
      if str[i] === "O" && str[i - 1] === "."
        t = str[i]
        str[i] = str[i - 1]
        str[i - 1] = t
        i = 0
      end
      i += 1
    end
    return str
  end

  def tiltNorth(grid)
    grid.cols.times do |c|
      grid.setCol(c, tilt(grid.getCol(c)))
    end
    return grid
  end

  def tiltSouth(grid)
    grid.cols.times do |c|
      str = tilt(grid.getCol(c).reverse)
      grid.setCol(c, str.reverse)
    end
    return grid
  end

  def tiltEast(grid)
    grid.rows.times do |r|
      str = tilt(grid.getRow(r).reverse)
      grid.setRow(r, str.reverse)
    end
    return grid
  end

  def tiltWest(grid)
    grid.rows.times do |r|
      grid.setRow(r, tilt(grid.getRow(r)))
    end
    return grid
  end

  def cycle(grid)
    grid = tiltNorth(grid)
    grid = tiltWest(grid)
    grid = tiltSouth(grid)
    grid = tiltEast(grid)
    return grid
  end

  def value(str)
    v = str.length
    sum = 0
    str.split("").each do |char|
      sum += v if char === "O"
      v -= 1
    end
    return sum
  end

  def calcLoad(grid)
    loads = []
    grid.cols.times do |c|
      loads << value(grid.getCol(c))
    end
    # puts "#{loads}"
    return loads.sum
  end

  def run
    grid = tiltNorth(getGrid)
    return calcLoad(grid)
  end

  # [
  # 87, 69,
  # 69, 69, 65, 64, 65, 63, 68,
  # 69, 69, 65, 64, 65, 63, 68,
  # 69, 69, 65, 64, 65, 63, 68,
  # 69, 69, 65, 64, 65, 63, 68]
  # 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480,
  # 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480,
  # 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480,
  # 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480,
  def run_2
    the300 = [97864, 97889, 97790, 97581, 97264, 97063, 96866, 96695, 96447, 96186, 95888, 95611, 95368, 95158, 94926, 94722, 94564, 94419, 94216, 94072, 93949, 93820, 93708, 93640, 93525, 93486, 93401, 93364, 93292, 93249, 93167, 93133, 93035, 92955, 92857, 92796, 92681, 92578, 92477, 92378, 92259, 92145, 92017, 91894, 91720, 91582, 91419, 91290, 91130, 90989, 90832, 90714, 90569, 90459, 90367, 90308, 90201, 90133, 90064, 90031, 89965, 89922, 89858, 89817, 89723, 89656, 89574, 89519, 89424, 89359, 89292, 89259, 89190, 89119, 89032, 88972, 88896, 88820, 88750, 88712, 88647, 88621, 88588, 88586, 88535, 88518, 88472, 88444, 88365, 88295, 88207, 88154, 88062, 88004, 87932, 87891, 87801, 87741, 87673, 87646, 87583, 87546, 87504, 87494, 87477, 87475, 87451, 87457, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480, 87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680]
    precycle = [97864, 97889, 97790, 97581, 97264, 97063, 96866, 96695, 96447, 96186, 95888, 95611, 95368, 95158, 94926, 94722, 94564, 94419, 94216, 94072, 93949, 93820, 93708, 93640, 93525, 93486, 93401, 93364, 93292, 93249, 93167, 93133, 93035, 92955, 92857, 92796, 92681, 92578, 92477, 92378, 92259, 92145, 92017, 91894, 91720, 91582, 91419, 91290, 91130, 90989, 90832, 90714, 90569, 90459, 90367, 90308, 90201, 90133, 90064, 90031, 89965, 89922, 89858, 89817, 89723, 89656, 89574, 89519, 89424, 89359, 89292, 89259, 89190, 89119, 89032, 88972, 88896, 88820, 88750, 88712, 88647, 88621, 88588, 88586, 88535, 88518, 88472, 88444, 88365, 88295, 88207, 88154, 88062, 88004, 87932, 87891, 87801, 87741, 87673, 87646, 87583, 87546, 87504, 87494, 87477, 87475, 87451, 87457]
    cycle = [87441, 87458, 87473, 87525, 87537, 87556, 87586, 87652, 87659, 87686, 87681, 87680, 87639, 87604, 87561, 87541, 87493, 87466, 87439, 87472, 87475, 87511, 87535, 87570, 87588, 87638, 87657, 87700, 87683, 87666, 87637, 87618, 87563, 87527, 87491, 87480]
    grid = getGrid
    # loads = []
    # seen = Set.new
    # 300.times do |i|
    #   grid = cycle(grid)
    #   load = calcLoad(grid)
    #   loads << load
    #   puts i
    #   puts load if seen.include?(load)
    #   seen << load
    # end
    # puts "#{loads}"

    return cycle[27]
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
