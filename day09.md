I managed to solve Day09 and I thought it went quite well. Then I watched [Kay planning how to do this](https://www.youtube.com/watch?v=fOSRD3T8PU0&t=3499s). She came up with an interesting idea: map out a function that decides what the tail should do given its relationship with the head.

> vector_diff(head, tail) => what_tail_should_do

I kind of saw a pattern and thought I might change my long-winded (29 lines) nested-ifs into something more compact.

```ruby
if hr == tr
  if tc == hc || tc == hc + 1 || tc == hc - 1
    return tail
  elsif hc - tc > 1
    return [tr, tc + 1]
  elsif tc - hc > 1
    return [tr, tc - 1]
  end
elsif hc == tc
  if tr == hr || tr == hr + 1 || tr == hr - 1
    return tail
  elsif hr - tr > 1
    return [tr + 1, tc]
  elsif tr - hr > 1
    return [tr - 1, tc]
  end
else # Neither the col nor row are the same
  if Math.hypot(hr - tr, hc - tc) < 2
    return tail
  elsif hr > tr && hc > tc # above right
    return [tr + 1, tc + 1]
  elsif hr > tr && hc < tc # above left
    return [tr + 1, tc - 1]
  elsif hr < tr && hc > tc # below right
    return [tr - 1, tc + 1]
  elsif hr < tr && hc < tc # below left
    return [tr - 1, tc - 1]
  end
end
```
It's a bodge, piecing together different situations as and when convenient.


I'm happier with the function I wrote below, but I'm not sure it's easier to read. 

I'm sure I will soon forget why I am doing what I am doing in the code below. But it's that kind of understanding of the problem, gained by investigating it thoroughly, that I should be practising by doing the problem analysis all over again.

```ruby
def update_tail(head, tail)
  hr, hc = head
  tr, tc = tail
  dr, dc = diff_vector(head, tail)
  modified_diff = [
    (dc.abs == 2 && dr.abs != 2) ? away_from_zero(dr) : dr,
    (dr.abs == 2 && dc.abs != 2) ? away_from_zero(dc) : dc
  ]
  tail_adjustment = [toward_zero(modified_diff[0]), toward_zero(modified_diff[1])]
  return add_vector(tail, tail_adjustment)
end
```
away_from_zero and towards_zero are increment and decrement but regarding magnitude rather than sign. 
```ruby
expect(toward_zero(3)).to eq 2
expect(toward_zero(-1)).to eq 0
expect(toward_zero(0)).to eq 0
expect(toward_zero(1)).to eq 0
expect(toward_zero(-3)).to eq -2

expect(away_from_zero(3)).to eq 4
expect(away_from_zero(-1)).to eq -2
expect(away_from_zero(0)).to eq 1
expect(away_from_zero(1)).to eq 2
expect(away_from_zero(-3)).to eq -4
```
