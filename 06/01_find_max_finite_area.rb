require 'pry-byebug'
input = File.readlines('input')
# input = DATA.readlines
coordinates = input.map { |row| row.split(', ').map(&:to_i) }

class Solution1
  attr_reader :coordinates
  attr_reader :min_x, :max_x, :min_y, :max_y
  attr_reader :least_distance

  def initialize(coordinates)
    @coordinates = coordinates
    @min_x, @max_x = coordinates.minmax_by { |x, _| x }.map!(&:first)
    @min_y, @max_y = coordinates.minmax_by { |_, y| y }.map!(&:last)
    @least_distance = {}
  end

  def run
    counter = 0
    area = []
    loop do
      x_range = (min_x - counter)..(max_x + counter)
      y_range = (min_y - counter)..(max_y + counter)
      counter += 1
      element_counts = find_element_counts_inside(x_range, y_range)
      area << element_counts
      # puts area
      # puts
      next if area.size < 3

      if found_all_finite_area?(area)
        print_finite_area(area)
        break
      else
        puts "Finite area not found yet"
        area.shift
      end
    end
  end

  # All finite elements are found if non of the element counts decrease
  # as the area increase
  def found_all_finite_area?(area)
    coordinates.each_index do |i|
      if area[2][i] - area[1][i] < area[1][i] - area[0][i]
        return false
      end
    end
    true
  end

  def print_finite_area(area)
    max_area = 0
    coordinates.each_index do |i|
      if (area[2][i] - area[1][i]).zero?
        max_area = area[2][i] if max_area < area[2][i]
        puts "Area #{i} has area #{area[2][i]}"
      end
    end

    puts "Max is #{max_area}"
  end

  def find_least_distance(x, y)
    return least_distance[[x, y]] if least_distance[[x, y]]

    distance_coordinates_group = coordinates.each_with_index.group_by do |(i, j), index|
      (x - i).abs + (y - j).abs
    end
    min_coordinates = distance_coordinates_group.min[1]
    least_distance[[x, y]] = min_coordinates.size == 1 ? min_coordinates[0][1] : nil
  end

  def find_element_counts_inside(x_range, y_range)
    elements = Hash.new(0)
    x_range.each do |x|
      y_range.each do |y|
        least_distance_coordinate_index = find_least_distance(x, y)
        elements[least_distance_coordinate_index] += 1 if least_distance_coordinate_index
        # puts "Finding for #{x}, #{y} = #{least_distance_coordinate_index}"
      end
    end
    elements
  end

  def includes_all_coordinates?(x_range, y_range)
    x_range.cover?(min_x) && x_range.cover?(max_x) &&
      y_range.cover?(min_y) && y_range.cover?(max_y)
  end
end

Solution1.new(coordinates).run


__END__
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
