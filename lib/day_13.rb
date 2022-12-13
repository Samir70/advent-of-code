require_relative "../utils/utils"
require "JSON"

class Solution13
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @data2 = []
    process
  end

  attr_reader :data

  def run
    comps = compare_all
    sum = 0
    comps.each_with_index do |val, i|
      sum += i + 1 if val
    end
    return sum
  end

  def run_2
    @data2.sort! {|a, b| compare(a, b) ? -1 : 1}
    # @data2.each do |line|
    #   puts "#{line}"
    # end

    a = @data2.index([[2]]) + 1
    b = @data2.index([[6]]) + 1
    return a * b
  end

  def compare(a, b)
    i = 0
    j = 0
    # puts "comparing #{a}"
    # puts "and #{b}"
    outcome = "same so far"
    while i < a.length && j < b.length
      if a[i].class == Array && b[j].class == Array
        # puts "found two arrays #{a[i]} and #{b[j]}"
        outcome = compare(a[i], b[j])
        # puts "got #{outcome}"
        if outcome == false
          return false
        end
      elsif a[i].class == Array && b[j].class == Integer
        # puts "found arr, int"
        outcome = compare(a[i], [b[j]])
        # puts "got #{outcome}"
        if outcome == false
          return false
        end
      elsif a[i].class == Integer && b[j].class == Array
        # puts "found int, arr"
        outcome = compare([a[i]], b[j])
        # puts "got #{outcome}"
        if outcome == false
          return false
        end
      else
        # puts "comparing #{a[i]} and #{b[j]}"
        outcome = a[i] == b[j] ? "same so far" : a[i] < b[j]
      end
      return outcome if outcome != "same so far"
      i += 1
      j += 1
    end
    # return "same so far" if a.length == b.length
    return a.length == b.length ? "same so far" : a.length < b.length
  end

  def compare_old(a, b)
    i = 0
    j = 0
    puts "comparing #{a}"
    puts "and #{b}"
    while i < a.length && j < b.length
      if a[i].class == Array && b[j].class == Array
        puts "found two arrays"
        outcome = compare(a[i], b[j])
        puts "got #{outcome}"
        if outcome == false
          return false
        end
      elsif a[i].class == Array && b[j].class == Integer
        puts "found arr, int"
        outcome = compare(a[i], [b[j]])
        puts "got #{outcome}"
        if outcome == false
          return false
        end
      elsif a[i].class == Integer && b[j].class == Array
        puts "found int, arr"
        outcome = compare([a[i]], b[j])
        puts "got #{outcome}"
        if outcome == false
          return false
        end
      else
        puts "comparing #{a[i]} and #{b[j]}"
        return true if a[i] < b[j]
        return false if a[i] > b[j]
      end
      i += 1
      j += 1
    end
    return true if a.length <= b.length
    return false if a.length > b.length
  end

  def compare_all
    out = []
    @data.each do |pair|
      left, right = pair
      result = compare(left, right)
      # puts "#{left}"
      # puts "#{right}"
      # puts result
      # puts ""
      out << result
    end
    return out
  end

  def process
    file = File.new(@file_name)
    @data = split_by_element(
      file.readlines.map(&:chomp).map { |line| line == "" ? "" : JSON.parse(line) },
      ""
    )
    file.close

    file = File.new(@file_name)
    @data2 = file.readlines
      .map(&:chomp).map { |line| line == "" ? "" : JSON.parse(line) }
      .select {|line| line != ""}
    file.close
    @data2.concat([[[2]], [[6]]])
  end
end
