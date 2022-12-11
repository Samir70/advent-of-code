class Solution11
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

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

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
