class MinHeapElement
  include Comparable
  attr_accessor :val, :priority

  def initialize(val, priority)
    @val, @priority = val, priority
  end

  def <=>(other)
    @priority <=> other.priority
  end

  def to_s
    puts "#{@val} = #{@priority}"
  end
end

class MinHeap
  attr_accessor :elements, :size

  def initialize
    @elements = [nil]
    @size = 0
  end

  def <<(element)
    @elements << element
    bubble_up(@elements.size - 1)
    @size += 1
  end

  def pop
    exchange(1, @elements.size - 1)
    max = @elements.pop
    bubble_down(1)
    @size -= 1
    return max
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end

  def bubble_up(child)
    # return if we reach the root element
    return if child <= 1

    parent_index = (child / 2)
    return if @elements[parent_index] <= @elements[child]
    exchange(child, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(parent)
    child_index = (parent * 2)

    return if child_index > @elements.size - 1

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element < left_element

    return if @elements[parent] <= @elements[child_index]

    exchange(parent, child_index)
    bubble_down(child_index)
  end
end

# q = MinHeap.new
# q << MinHeapElement.new("myself", 3)
# q << MinHeapElement.new("me", 2)
# q << MinHeapElement.new("I6", 6)
# q << MinHeapElement.new("I4", 4)
# q << MinHeapElement.new("I1", 1)

# puts q.elements
# q.pop()
# puts q.elements
