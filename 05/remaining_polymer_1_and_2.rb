input = File.read('input').tap(&:chomp!)
# input = DATA.read.tap(&:chomp!)

class String
  alias_method :each, :each_char
end

def reduce_polymer(large_polymer)
  polymer = []
  large_polymer.each do |char|
    if polymer[-1] == char.swapcase
      polymer.pop
    else
      polymer.push(char)
    end
  end
  polymer
end

reduced_polymer = reduce_polymer(input)
puts "Part1: Polymer size after reduction #{reduced_polymer.join.size}"

# Solution1 10762

# Part 2

uniq_chars = reduced_polymer.uniq(&:downcase)
uniq_chars_with_sizes = uniq_chars.map do |char|
  polymer_without_char = reduced_polymer - [char, char.swapcase]
  [char, reduce_polymer(polymer_without_char).join.size]
end

char, min_size = uniq_chars_with_sizes.min_by { |_k, v| v }

puts "Part2: Min size for #{char} is #{min_size}"

# Solution2 6946

__END__
dabAcCaCBAcCcaDA
