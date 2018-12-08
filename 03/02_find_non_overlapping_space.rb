inputs = File.readlines("input")
# inputs = DATA.readlines

square_size = 1000

def parse_row(row)
  matches = row.match(/#([0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/)
  raise "String #{row} does not match" unless matches

  matches[1, 5].map(&:to_i)
end

space = Array.new(square_size) { Array.new(square_size, 0) }

inputs.each do |input|
  _, x, y, l, h = parse_row(input)
  (x..(x + l - 1)).each do |i|
    (y..(y + h - 1)).each do |j|
      space[j][i] += 1
    end
  end
end

def only_ones?(space, x, y, l, h)
  has_only_ones = true
  (x..(x + l - 1)).each do |i|
    (y..(y + h - 1)).each do |j|
      if space[j][i] > 1
        has_only_ones = false
        break
      end
    end
  end
  has_only_ones
end

inputs.each do |input|
  id, x, y, l, h = parse_row(input)
  if only_ones?(space, x, y, l, h)
    puts "Found id #{id}"
    break
  end
end

# Solution 717

__END__
#1 @ 3,2: 4x4
#1 @ 3,2: 4x5
