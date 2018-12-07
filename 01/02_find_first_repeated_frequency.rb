# We use a hash key to store all past sums
# If we used an array, the algorithm will take O(n^2) time
# because we have to look up n times in an array of m values
# Instead, hash keys have an O(1) performance and therefore it's MUCH MUCH faster

sum = 0
all_calculated_frequencies = { 0 => true }
found_duplicate_sum = false

input_frequencies = File.readlines("input").map!(&:to_i)

while (!found_duplicate_sum) do
  input_frequencies.each do |i|
    sum += i
    if all_calculated_frequencies.key?(sum)
      found_duplicate_sum = sum
      break
    else
      all_calculated_frequencies[sum] = true
    end
  end
end

puts "Repeated frequency : #{found_duplicate_sum}"
puts "Total calculated frequencies : #{all_calculated_frequencies.size}"

# Solution: 241
