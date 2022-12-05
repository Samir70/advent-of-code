class Solution09
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run
  
  end

  def run_2
  
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
