class Solution17
  def initialize(file_name)
    @file_name = file_name
    @data = []
    process
  end

  def run(rocks)
    tb = TetrisBoard.new()
    # puts "#{@data[0].length}"
    base = @data[0].length * 5 * 7
    not_found_repeat = true
    height_at_first_rpt = 0
    heights = [0]
    prev = 0
    jet = 0
    seen = Set.new()
    rocks.times do |i|
      tb.add(Sprites[i % 5])
      # puts "Adding rock #{i + 1}\n #{Sprites[i % 5]}"
      can_drop = true
      while can_drop
        dir = @data[0][jet]
        tb.left if dir == "<"
        tb.right if dir == ">"
        # puts dir == "<" ? "#{[dir, jet]}:: left" :  "#{[dir, jet]}:: right"
        can_drop = tb.down
        jet += 1
        jet = 0 if jet >= @data[0].length
      end
      summary = "rocks mod #{base}: #{(i + 1) % base} => #{tb.summary}"
      if seen.include?(summary)
        # puts tb
        # puts summary
        # puts "rock #{i + 1}, height: #{tb.height}"
        if not_found_repeat
          seen = Set.new()
          seen.add(summary)
          height_at_first_rpt = tb.height
        else
          diff = tb.height - height_at_first_rpt
          # puts "2nd rpt, height diff is: #{diff}"
          future_rpts = (rocks - (i + 1)) / base
          # puts "need to do this #{future_rpts} more times"
          # puts "which will give us #{future_rpts * base} more rocks and #{future_rpts * diff} more height"
          total_rocks = i + 1 + future_rpts * base
          total_height = tb.height + future_rpts * diff
          # puts "rocks by then: #{total_rocks}, height: #{total_height}"
          rocks_needed = rocks - total_rocks
          # puts "then we will need #{rocks_needed} more rocks"
          height_at_rpt_plus_rocks_needed = heights[i + 1 - base + rocks_needed]
          extra_height = height_at_rpt_plus_rocks_needed - height_at_first_rpt
          return total_height + extra_height
        end
        not_found_repeat = false
      end
      if i % base == 0
        diff = tb.height - prev
        prev = tb.height
        # puts "rock: #{i + 1}  diff: #{diff}"
      end
      seen.add(summary) if not_found_repeat
      heights << tb.height
    end
    # puts tb
    return tb.height
  end

  def get_diffs(rocks)
    tb = TetrisBoard.new()
    puts "#{@data[0].length}"
    diffs = ""
    prev_height = 0
    jet = 0
    rocks.times do |i|
      tb.add(Sprites[i % 5])
      # puts "Adding rock #{i + 1}\n #{Sprites[i % 5]}"
      can_drop = true
      while can_drop
        dir = @data[0][jet]
        tb.left if dir == "<"
        tb.right if dir == ">"
        # puts dir == "<" ? "#{[dir, jet]}:: left" :  "#{[dir, jet]}:: right"
        can_drop = tb.down
        jet += 1
        jet = 0 if jet >= @data[0].length
      end
      h = tb.height
      diffs += (h - prev_height).to_s
      prev_height = h
    end
    # puts diffs
    return diffs
  end


  def run_4(rocks)
    before_rpt = "133021303002220130201322202212122021234013300121200322213222133000030013220020120322013020121221332002211133221321213220132001330000322101301300213340132000230213342133001230013320122201022002212133001304213340121121324212210033201031202340103011222013340132121302012122132400032013300013011320013300020301222013300132000230202322123001330002302103110304013212132201230113032130201322002222133000232210310133221320012140130301303"
    rpted_incs = "20034213322133021320013320122220030003201023201330202142132201322213322003201322213030103111332213040023001232213222132011330012320133000234013300133001234013220133021230013302123201330013302130021334002212132201332213340130300212212220123021330012302132001332010302133221214212220102201212013200130201230013340121301322013240121421303013200133421324213340003001332002202121220032200020132201320113040130201330013340132221334203211132201224010302133221230013302132201330002200133201301210220033020030003222130421324013342103001330200300122400034213300133001212013342122001332213042132201330013030023201232013300123401324013320132421321013200133421232212342133201330210300133021330212120123020330013300023201300013220021401324013220103400222013002013201212210320130021232200242122201221113210133001301013300130221324213322132001303013302132221212213200023201330013222132400034002300133221330013320033221221002130123001222213300133401330011302132220300201220132201330012120132201232012240003001122013342000401213001210021201320013030033221222013220132201212002301123021330211302130221330013200123021324012302132011322212302123201330203212032201322212220123001212002320132201330213220133021032212122130301032013322133201334002300132101031003322132201300013300132201330213201132400032013320132401302202220123421303012320103201334010320133001334013302132221330002011132111330012340132001232001210033421303013022133201302012320132201213001302123201212013320121401334013200132221230013300133001232013022132200234013040123401322213320023401212013212121321213001222030400220003022133001232013042132200220013322132201320012322123201322013020121201321012132133201234003042133220232012222020021230001300023401212"
    rocks_before_rpt = before_rpt.length
    height_before_rpt = before_rpt.split("").map(&:to_i).sum
    # puts "before repeat: #{rocks_before_rpt} rocks and height #{height_before_rpt}"
    rocks_needed = rocks - rocks_before_rpt
    # puts "need another #{rocks_needed} rocks"
    rocks_in_rpt = rpted_incs.length
    height_added_in_rpt = rpted_incs.split("").map(&:to_i).sum
    # puts "rocks in rpt: #{rocks_in_rpt}, and they add #{height_added_in_rpt} in height"
    rpts_needed = rocks_needed / rocks_in_rpt
    added_rocks = rocks_in_rpt * rpts_needed
    added_height = rpts_needed * height_added_in_rpt
    # puts "repeat #{rpts_needed} times, adding #{added_rocks} rocks and #{added_height} height"
    rocks_needed = rocks - (rocks_before_rpt + added_rocks)
    # puts "need another #{rocks_needed} rocks"
    last_added_height = rpted_incs[0...rocks_needed].split("").map(&:to_i).sum
    return height_before_rpt + added_height + last_added_height
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp)
    file.close
  end
end



sprite0 = ["|..@@@@.|"]
sprite1 = [
  "|...@...|",
  "|..@@@..|",
  "|...@...|",
]
sprite2 = [
  "|..@@@..|",
  "|....@..|",
  "|....@..|",
]
sprite3 = [
  "|..@....|",
  "|..@....|",
  "|..@....|",
  "|..@....|",
]
sprite4 = [
  "|..@@...|",
  "|..@@...|",
]
Sprites = [sprite0, sprite1, sprite2, sprite3, sprite4]

class TetrisBoard
  def initialize
    @board = ["+-------+"]
    @dropped_rows = 0
    @sprite_rows = []
  end

  attr_reader :board, :sprite_rows

  def height
    return @dropped_rows + @board.length - 1
  end

  def add(sprite)
    @board.concat(["|.......|", "|.......|", "|.......|"])
    @sprite_rows = []
    sprite.length.times do |i|
      @sprite_rows << @board.length + i
    end
    @board.concat(sprite.map { |s| String.new(s) })

    max_height = 100
    if @board.length > max_height * 2
      @board = @board[max_height..-1]
      @dropped_rows += max_height
      @sprite_rows.map! { |r| r - max_height }
    end
  end

  def left
    rows = @board[@sprite_rows.first..@sprite_rows.last]
    if rows.all? { |el| el.include?(".@") }
      for i in @sprite_rows.first..@sprite_rows.last
        # puts "row #{i} is #{@board[i]}"
        @board[i] = shift_left(@board[i])
      end
      # to_s
      return true
    else
      return false
    end
  end

  def right
    rows = @board[@sprite_rows.first..@sprite_rows.last]
    if rows.all? { |el| el.include?("@.") }
      for i in @sprite_rows.first..@sprite_rows.last
        # puts "row #{i} is #{@board[i]}"
        @board[i] = shift_right(@board[i])
      end
      # to_s
      return true
    else
      return false
    end
  end

  def down
    rows = @board[@sprite_rows.first - 1..sprite_rows.last]
    # puts "trying to drop, #{@sprite_rows} are #{rows}"
    # I change the strings in rows, then I change the strings in @board -- they are the same object.
    if can_drop?(rows)
      for r in 1...rows.length
        for c in 1..7
          if rows[r][c] == "@"
            # puts "moving sprite at #{[r, c]}, below is #{rows[r-1][c]}"
            rows[r - 1][c] = "@"
            rows[r][c] = "."
          end
        end
      end
      @board.pop if @board.last == "|.......|"
      @sprite_rows.map! { |r| r - 1 }
      return true
    else
      for r in 1...rows.length
        for c in 1..7
          if rows[r][c] == "@"
            # puts "moving sprite at #{[r, c]}, below is #{rows[r-1][c]}"
            rows[r][c] = "#"
          end
        end
      end
      return false
    end
  end

  def can_drop?(rows)
    # puts rows
    for r in 1...rows.length
      for c in 1..7
        if rows[r][c] == "@"
          # puts "found a sprite at #{[r, c]}, below is #{rows[r-1][c]}"
          return false if !".@".include?(rows[r - 1][c])
        end
      end
    end
    return true
  end

  def shift_left(str)
    i = 1
    while i < 7
      if str[i] == "." && str[i + 1] == "@"
        str[i + 1], str[i] = str[i], str[i + 1]
      end
      i += 1
    end
    return str
  end

  def shift_right(str)
    i = 7
    while i > 0
      if str[i - 1] == "@" && str[i] == "."
        str[i - 1], str[i] = str[i], str[i - 1]
      end
      i -= 1
    end
    return str
  end

  def summary
    start = -[@board.length, 7].min
    out = ""
    return @board[start..-1].join(", ")
  end

  def to_s
    start = -[@board.length, 7].min
    puts "tetris board is:"
    @board[start..-1].reverse.each do |line|
      puts line
    end
  end
end

class PossAns
  def initialize
    @ans_list = Hash.new(0)
  end
  attr_reader :ans_list

  def add(n)
    @ans_list[n] += 1
  end

  def best_ans
    return @ans_list.keys().max { |key| @ans_list[key] }
  end

  def to_s
    for key in @ans_list.keys() do
      puts "Answer #{key} came up #{@ans_list[key]} times"
    end
    # best = best_ans()
    # puts "Answer #{best} came up #{@ans_list[best]} times"
  end
end
