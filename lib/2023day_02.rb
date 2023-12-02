class Solution02
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run(r, g, b)
    sum = 0
    @data.each do |game|
      res = splitGame(game)
      if res[:max][0] <= r && res[:max][1] <= g && res[:max][2] <= b
        sum += res[:id]
      end
    end
    return sum
  end

  def rgb(grab)
    cols = grab.split(",")
    out = {}
    cols.each do |col|
      out[col.split(" ")[1].to_sym] = col.split(" ")[0].to_i
    end
    return out
  end

  def findMax(grabList)
    red = 0
    green = 0
    blue = 0
    grabList.each do |grab|
      if grab[:red] && grab[:red] > red 
        red = grab[:red]
      end
      if grab[:green] && grab[:green] > green 
        green = grab[:green]
      end
      if grab[:blue] && grab[:blue] > blue 
        blue = grab[:blue]
      end
    end
    return [red, green, blue]
  end

  def splitGame(game) 
    split1 = game.split(":")
    id = split1[0].split(" ")[1].to_i
    out = {id: id}
    grabs = split1[1].split(";").map do |el|
      rgb(el)
    end
    out[:max] = findMax(grabs)
    return out
  end

  def power(game)
    reqd = splitGame(game)[:max]
    return reqd[0] * reqd[1] * reqd[2]
  end

  def run_2
    sum = 0
    @data.each do |game|
      sum += power(game)
    end
    return sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end
