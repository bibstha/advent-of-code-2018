# frozen_string_literal: true
class Solution1
  def initialize
    @input = DATA.readlines.first.to_i
    @grid = Array.new(300) { Array.new(300) }
    @cache = {}
  end

  def run
    compute_grid
    # puts compute_sum(32, 44, 14)
    x, y, grid_size, val = find_largest_grid
    puts "X: #{x}, Y: #{y}, GridSize: #{grid_size}, Val: #{val}"
  end

  def compute_grid
    300.times do |i|
      300.times do |j|
        x = i + 1
        y = j + 1
        @grid[i][j] = compute_cell(x, y)
      end
    end
  end

  def compute_cell(x, y)
    rack_id = x + 10
    power_level = rack_id * y
    power_level += @input
    power_level *= rack_id
    digit = power_level.to_s[-3].to_i
    digit - 5
  end

  def find_largest_grid
    # x, y, grid_size, value
    max_grid = [1, 1, 1, 0]
    300.times do |k|
    # 20.times do |k|
      grid_size = k+1
      puts "Computing for grid size #{grid_size}: #{max_grid.inspect}"
      (300-grid_size).times do |i|
        (300-grid_size).times do |j|
          x = i+1
          y = j+1
          sum = compute_sum(i, j, grid_size)
          if sum > max_grid.last
            max_grid = [x, y, grid_size, sum]
          end
        end
      end
    end
    max_grid
  end

  # sum of grid_size at x, y =
  # sum of (grid_size - 1) at x, y + the right and bottom border with grid_size=1
  def compute_sum(i, j, grid_size)
    return @grid[i][j] if grid_size == 1

    key = i * 1_000_000 + j * 1_000 + grid_size # fastest with int index
    # key = "#{i}-#{j}-#{grid_size}" # slower
    # key = [i, j, grid_size] # slowest
    return @cache[key] if @cache[key]

    val = compute_sum(i, j, grid_size - 1) +
      grid_size.times.sum { |k| @grid[i+grid_size-1][j+k] } +
      grid_size.times.sum { |k| @grid[i+k][j+grid_size-1] } -
      @grid[i+grid_size-1][j+grid_size-1]

    @cache[key] = val
  end
end

Solution1.new.run

# solution1 20,50
# solution2 238,278,9

__END__
2866
