inputs = File.readlines("input")
two_count = 0
three_count = 0

def has2_or_3(input)
  character_counts = input.split("").group_by(&:itself).map { |k, v| v.size }
  [
    character_counts.include?(2),
    character_counts.include?(3),
  ]
end

inputs.each do |input|
  has2, has3 = has2_or_3(input)
  two_count += 1 if has2
  three_count += 1 if has3
end

puts "Two counts #{two_count}"
puts "Three counts #{three_count}"
puts "Checksum = #{two_count}*#{three_count} = #{two_count * three_count}"


__END__

Solution: 4712

Advent of Code

    [About][Events][Shop][Settings][Log Out]

Bibek Shrestha 2*
   int y=2018;

    [Calendar][AoC++][Sponsors][Leaderboard][Stats]

Our sponsors help make Advent of Code possible:
Rainway - Play all your favorite PC games anytime, anywhere, across a variety of different devices.
--- Day 2: Inventory Management System ---

You stop falling through time, catch your breath, and check the screen on the device. "Destination reached. Current Year: 1518. Current Location: North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.

Outside the utility closet, you hear footsteps and a voice. "...I'm not sure either. But now that so many people have chimneys, maybe he could sneak in that way?" Another voice responds, "Actually, we've been working on a new kind of suit that would let him fit through tight spaces like that. But, I heard that a few days ago, they lost the prototype fabric, the design plans, everything! Nobody on the team can even seem to remember important details of the project!"

"Wouldn't they have had enough fabric to fill several boxes in the warehouse? They'd be stored together, so the box IDs should be similar. Too bad it would take forever to search the warehouse for two similar box IDs..." They walk too far away to hear any more.

Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).

To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

For example, if you see the following box IDs:

    abcdef contains no letters that appear exactly two or three times.
    bababc contains two a and three b, so it counts for both.
    abbcde contains two b, but no letter appears exactly three times.
    abcccd contains three c, but no letter appears exactly two times.
    aabcdd contains two a and two d, but it only counts once.
    abcdee contains two e.
    ababab contains three a and three b, but it only counts once.

Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

What is the checksum for your list of box IDs?

To begin, get your puzzle input.

Answer:

You can also [Shareon Twitter Reddit] this puzzle.

