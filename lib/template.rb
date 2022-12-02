class CountCals
    def initialize(file_name)
      @file_name = file_name
    end
  
    def run
      file = File.new(@file_name)
      file_data = file.readlines.map(&:to_i)
      file_data.each do |line|
          puts line
      end
      file.close 
    end
  end
  