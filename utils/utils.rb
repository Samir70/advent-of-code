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
