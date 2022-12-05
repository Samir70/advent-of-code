class Solution02
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
    plays = []
    @data.each do |round|
      play = round.split(" ")
      a = convert(play[0])
      x = convert(play[1])
      # puts "run #{play}, #{[a, x]}"
      plays << [a, x]
    end
    return plays.map { |p| score(p[0], p[1]) }.sum
  end

  def convert(char)
    # puts "convert #{char}"
    if "ABC".include?(char)
      return "-ABC".index(char)
    end
    if "XYZ".include?(char)
      return "-XYZ".index(char)
    end
  end

  def score(a, b)
    # draw
    if a == b
      return b + 3
    end
    # puts "comparing #{[a, b]}"
    case a
    when 1
      # puts "a == 1 #{[a, b]}"
      return b == 2 ? 8 : b
    when 2
      # puts "a == 2 #{[a, b]}"
      return b == 1 ? b : 9
    else
      # a == 3
      # puts "a == 3 #{[a, b]}"
      return b == 1 ? 7 : b
    end
  end

  def choose_rps(str)
    elf = str[0]
    outcome = str[2]
    case outcome
    when "X"
      return elf == "A" ? "C" : elf == "B" ? "A" : "B"
    when "Y"
      return elf
    else
      return elf == "A" ? "B" : elf == "B" ? "C" : "A"
    end
  end

  def run_2
    @data.map! { |play| "#{play[0]} #{choose_rps(play)}" }
    run
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
