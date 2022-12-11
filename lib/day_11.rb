Monkey = Struct.new(:items, :operation, :div_test, :true_monkey, :false_monkey, :activity)

class Solution11
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @monkeys = []
    process
  end

  attr_reader :monkeys

  def run
  end

  def run_2
  end

  def split_by_element(arr, val)
    out = []
    group = []
    arr.each do |line|
      if line != val
        group << line
      else
        out << group
        group = []
      end
    end
    out << group
    return out
  end

  def extract_monkeys
    # Monkey = Struct.new(:items, :operation, :div_test, :true_monkey, :false_monkey, :activity)
    # ["Monkey 0:", "  Starting items: 79, 98", "  Operation: new = old * 19", "  Test: divisible by 23", "    If true: throw to monkey 2", "    If false: throw to monkey 3"]
    @data.each do |data_block|
      # puts "#{data_block}"
      items = data_block[1].split(":")[1].split(",").map(&:to_i)
      operation = data_block[2].split("old")[1].split(" ")
      operation[1] = operation[1].to_i
      div_test = data_block[3].split("divisible by")[1].to_i
      true_monkey = data_block[4].split("throw to monkey")[1].to_i
      false_monkey = data_block[5].split("throw to monkey")[1].to_i
      @monkeys << Monkey.new(items, operation, div_test, true_monkey, false_monkey, 0)
    end
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close

    @data = split_by_element(@data, "")
    extract_monkeys
  end
end
