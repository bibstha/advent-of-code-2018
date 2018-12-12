require 'awesome_print'
class Solution
  def initialize
    @input = File.readlines('input')
    # @input = DATA.readlines

    @generations = 200
    @offset = 10
    @offset_end = 150

    @offset_string = "." * @offset
    @offset_end_string = "." * @offset_end

    parse_input
  end

  def parse_input
    @initial_state = @input.first.match(/initial state: ([#\.]+)/)[1]
    @pots = "#{@offset_string}#{@initial_state}#{@offset_end_string}"
    @rules = {}
    @input[2..-1].each do |rule|
      result = rule.match /([#\.]{5}) => ([#\.]{1})/
      @rules[result[1]] = result[2]
    end
  end

  def simulate_generations
    pot_len = @pots.size
    @dup_pots = @pots.dup
    sum = print_sum
    puts "0 #{@dup_pots} - Sum: #{sum}"

    (@generations).times do |i|
      (pot_len-5).times do |j|
        current_status = @pots[j, 5]
        next_status = @rules[current_status]
        @dup_pots[j+2] = next_status
      end
      @pots = @dup_pots.dup
      new_sum = print_sum
      puts "#{i+1} #{@pots} s: #{new_sum} d: #{new_sum - sum}"
      sum = new_sum
    end
  end

  def print_sum
    sum = 0
    @pots.each_char.with_index do |char, i|
      if char == '#'
        sum += i - @offset
      end
    end
    sum
  end

  # Looking at the sums, after 101th iteration it increments by 50 per generation
  def print_sum_5_billion
    increment = 50
    counter = 101
    sum = 6225

    target_generation = 50_000_000_000
    (target_generation - counter) * increment + sum
  end

  def run
    simulate_generations
    print_sum
    puts "Sum at 50 billing : #{target_generation}"
  end
end

Solution.new.run


__END__
initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #
