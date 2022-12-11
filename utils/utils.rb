def string_to_grid(str, width)
  out = []
  first = 0
  last = width
  while first < str.length do
    out << str[first...last]
    first = last
    last += width
  end
  return out
end

def split_by_element(arr, val)
  out = []
  group = []
  arr.each do |line|
    if line != val
      group << line
    else
      out << group if group.length > 0
      group = []
    end
  end
  out << group
  return out
end

