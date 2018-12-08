require 'pry-byebug'

class Solution2
  attr_reader :coordinates
  attr_reader :min_x, :max_x, :min_y, :max_y
  attr_reader :max_distance
  attr_reader :distance_cache

  def initialize
    input = File.readlines('input')
    # input = DATA.readlines
    @coordinates = input.map { |row| row.split(', ').map(&:to_i) }

    @min_x, @max_x = coordinates.minmax_by { |x, _| x }.map!(&:first)
    @min_y, @max_y = coordinates.minmax_by { |_, y| y }.map!(&:last)

    # @max_distance = 32 - 1
    @max_distance = 10_000 - 1
    @distance_cache = {}
  end

  def run
    base_area_count = 0
    counter = 0
    loop do
      x_range = (min_x - counter)..(max_x + counter)
      y_range = (min_y - counter)..(max_y + counter)
      counter += 1

      new_area_count = count_max_distances_in(x_range, y_range)
      if new_area_count <= base_area_count
        puts "Total area #{new_area_count}"
        break
      end

      puts "New #{new_area_count} vs Old #{base_area_count}"
      base_area_count = new_area_count
    end
  end

  def count_max_distances_in(x_range, y_range, base = true)
    under_max_distance_count = 0
    if base
      x_range.each do |x|
        y_range.each do |y|
          distance = calculate_distance_sum(x, y)
          under_max_distance_count += 1 if distance <= max_distance
        end
      end
    else
      # top row, x_range, y_range.begin
      # bottom row x_range, y_range.end
      # left x_range.begin, y_range
      # right x_range.end, y_range
      # - x_range.begin, y_range.begin
      # - x_range.end, y_range.end
      # - x_range.begin, y_range.end
      # - x_range.end, y_range.begin
    end
    under_max_distance_count
  end

  def calculate_distance_sum(x, y)
    key = [x, y]
    return distance_cache[key] if distance_cache[key]

    distance_cache[key] = coordinates.sum do |i, j|
      (x - i).abs + (y - j).abs
    end
  end

end

Solution2.new.run


__END__
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
