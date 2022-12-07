class Solution07
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @directories = []
    @files = []
    process
  end

  def run
    sizes = []
    # puts "#{@files}"
    @directories = @directories.uniq
    @directories.each do |dir|
      to_total = @files.select {|el| el[0].include?(dir)}
      size = to_total.map {|el| el[1]}.sum
      # puts "working on #{dir}:: #{size}"
      sizes << size
    end
    return sizes.select {|el| el <= 100000}.sum
  end

  def run_2
    sizes = []
    size_of_root = @files.map {|el| el[1]}.sum
    space_available = 70000000 - size_of_root
    space_needed = 30000000 - space_available
    # puts "#{@files}"
    @directories = @directories.uniq
    @directories.each do |dir|
      to_total = @files.select {|el| el[0].include?(dir)}
      size = to_total.map {|el| el[1]}.sum
      # puts "working on #{dir}:: #{size}"
      sizes << size
    end
    return sizes.select {|el| el >= space_needed}.min
  end

  def has_dir?(dir)
    return @directories.select { |el| el.name == dir }[0]
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
    path = ["//"]
    adding = false
    @data.each do |line|
      if line.start_with?("$ cd")
        new_dir_name = line.split(" ")[2]
        if new_dir_name == ".."
          path.pop
          if path.length == 0
            path = ["//"]
          end
        else
          path << new_dir_name
          @directories << "#{path.join("/")}/"
        end
        adding = false
        # puts line, path.join("/")
      end

      if adding
        if !line.start_with?("dir")
          # puts "adding #{line} to #{path.join("/")}"
          size, f_name = line.split(" ")
          @files << ["#{path.join("/")}/#{f_name}", size.to_i]
        else 
          # d_name = line.split(" ")[1]
          # @directories << "#{path.join("/")}/#{d_name}"
          # puts "added directory #{d_name}"
        end
        # puts @files
      end

      if line == "$ ls"
        adding = true
      end
    end
  end

  attr_reader :directories
end
