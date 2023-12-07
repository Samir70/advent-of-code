class Card
  def initialize(c, b, t, t2)
    @cardVals = {
      "A" => "m",
      "K" => "l",
      "Q" => "k",
      "J" => "j",
      "T" => "i",
      "9" => "h",
      "8" => "g",
      "7" => "f",
      "6" => "e",
      "5" => "d",
      "4" => "c",
      "3" => "b",
      "2" => "a",
    }
    @cardVals2 = {
      "A" => "m",
      "K" => "l",
      "Q" => "k",
      "T" => "j",
      "9" => "i",
      "8" => "h",
      "7" => "g",
      "6" => "f",
      "5" => "e",
      "4" => "d",
      "3" => "c",
      "2" => "b",
      "J" => "a",
    }
    @cards = c
    @bid = b
    @type = t
    @type2 = t2
    @sortable = c.split("").map { |el| @cardVals[el] }.join("")
    @sortable2 = c.split("").map { |el| @cardVals2[el] }.join("")
  end

  def <=>(other)
    @sortable <=> other.sortable
  end

  def to_s
    [@cards, @type, @type2].join("-")
  end

  attr_accessor :cards, :bid, :type, :type2, :sortable, :sortable2
end

class Solution07
  def initialize(file_name)
    @file_name = file_name
    @data = []
    @cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
    process
  end

  def classifyHand(str)
    cards = str.split("").sort()
    counts = @cards.map { |c| str.count(c) }
    a, b = counts.sort.reverse
    # puts [a, b].join("-")
    return 0 if a == 1
    return 1 if a == 2 && b == 1
    return 2 if a == 2 && b == 2
    return 3 if a == 3 && b == 1
    return 4 if a == 3 && b == 2
    return 5 if a == 4
    return 6 if a == 5
  end

  def classifyHand2(str)
    cards = str.split("").sort()
    counts = @cards.map { |c| str.count(c) }
    a, b = counts.sort.reverse
    jokers = str.count("J")
    if a == 1 && b == 1
      a += jokers
    elsif a == 2 && b == 1
      jokers = 1 if jokers == 2
      a += jokers
      # whether it is 1 joker or 2, best is three of a kind
    elsif a == 2 && b == 2
      # 0 jokers gets us to 2-2
      # 1 joker gets us to 3-2
      # 2 jokers gets us to 4-1, but val of b doesn't matter in below returns
      a += jokers
    elsif a == 3 && b == 1
      # 0 jokers gets us to 3-1
      # 1 joker gets us to 4-1
      # 3 jokers gets us to 4-1, but val of b doesn't matter in below returns
      jokers = 1 if jokers == 3
      a += jokers
    elsif a == 3 && b == 2
      # 0 jokers gets us to 3-2
      # 2 or 3 jokers gets us to 5-0, but val of b doesn't matter in below returns
      a += jokers
    else
      # 4-1  
      jokers == 1 if jokers == 4
      a += jokers
    end
    # puts [str, a, b].join("-")
    return 0 if a == 1
    return 1 if a == 2 && b == 1
    return 2 if a == 2 && b == 2
    return 3 if a == 3 && b == 1
    return 4 if a == 3 && b == 2
    return 5 if a == 4
    return 6 if a >= 5
  end

  def splitInput(line)
    cards, bid = line.split(" ")
    return Card.new(cards, bid.to_i, classifyHand(cards), classifyHand2(cards))
  end

  def sortCards
    return @data.sort { |a, b| a.type == b.type ? a <=> b : a.type <=> b.type }
  end

  def sortCards2
    return @data.sort { |a, b| a.type2 == b.type2 ? a.sortable2 <=> b.sortable2 : a.type2 <=> b.type2 }
  end

  def run
    sum = 0
    sortCards.each.with_index do |card, i|
      # puts "rank: #{i + 1}, cards: #{card.cards}, type: #{card.type} bid: #{card.bid}"
      sum += (i + 1) * card.bid
    end
    return sum
  end

  def run_2
    sum = 0
    # puts @data
    sortCards2.each.with_index do |card, i|
      # puts "rank: #{i + 1}, cards: #{card.cards}, type: #{card.type2} bid: #{card.bid}" if card.cards.include?("J")
      sum += (i + 1) * card.bid
    end
    return sum
  end

  def process
    file = File.new(@file_name)
    @data = file.readlines.map(&:chomp).map { |line| splitInput(line) }
    file.close
  end
end
