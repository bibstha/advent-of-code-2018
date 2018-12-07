inputs = File.readlines("input")

def count_char_difference(str1, str2)
  str1.each_char.zip(str2.each_char)
    .sum { |char_str1, char_str2| (char_str1 == char_str2) ? 0 : 1 }
end

def print_common_chars(str1, str2)
  puts str1.each_char.zip(str2.each_char)
    .map! { |char1, char2| (char1 == char2) ? char1 : nil }
    .compact.join
end

inputs.each_with_index do |str1, i|
  found = false
  inputs.each do |str2|
    diff = count_char_difference(str1, str2)
    if diff == 1
      puts str1
      puts str2
      puts "Common characters #{print_common_chars(str1, str2)}"
      found = true
      break
    end
  end
  break if found
end


__END__

Solution: lufjygedpvfbhftxiwnaorzmq

--- Part Two ---

Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz

The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)


