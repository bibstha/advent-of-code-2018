sum = 0
File.open("input", "r") do |f|
  f.each_line do |value|
    sum += value.to_i
  end
end
puts sum

# OR

# puts File.readlines("input").map!(&:to_i).sum

# Solution: 592
