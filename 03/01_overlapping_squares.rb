inputs = File.readlines("input")
# inputs = DATA.readlines

square_size = 1000

def parse_row(row)
  matches = row.match(/@ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/)
  raise "String #{row} does not match" unless matches

  matches[1, 4].map(&:to_i)
end

space = Array.new(square_size) { Array.new(square_size, 0) }

inputs.each do |input|
  x, y, l, h = parse_row(input)
  (x..(x + l - 1)).each do |i|
    (y..(y + h - 1)).each do |j|
      space[j][i] += 1
    end
  end
end

total = space.sum do |column_array|
  column_array.sum { |x| x > 1 ? 1 : 0 }
end

puts total

# Solution 97218

__END__
#1 @ 3,2: 4x4
#1 @ 3,2: 4x5
