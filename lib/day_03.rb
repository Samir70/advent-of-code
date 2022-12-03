class Solution03
  def initialize(file_name)
    @file_name = file_name
    process
  end

  def run
  
  end

  def process
    file = File.new(@file_name)
    file_data = file.readlines.map(&:to_i)
    file.close
  end
end
