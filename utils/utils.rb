def string_to_grid(str, width)
  out = []
  first = 0
  last = width
  while first < str.length
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

def do_op(*args)
  if args.length == 3
    a, op, b = args
  else
    a, op, b = args[0].split(/(\*|\/|\+|\-\s)/)
    op = "-" if op == "- "
    a = a.to_i
    b = (b == "self" || b == " self") ? a : b.to_i
    return do_op(a.to_i, op, b)
  end
  if op == "*"
    return a * b # day_11 used (b == 0 ? a : b)
  elsif op == "/"
    return a / b
  elsif op == "+"
    return a + b
  elsif op == "-"
    return a - b
  end
  return nil
end
