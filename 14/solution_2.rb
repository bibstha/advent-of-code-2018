class Solution
  def initialize
    @input = 409551
    @input_size = @input.to_s.length

    @array = Array.new(1_000_000) # Brings time down from 26 seconds to 5.5 seconds
    @array[0] = 3
    @array[1] = 7
    @e1_pos = 0
    @e2_pos = 1
    @recipe_count = 2
  end

  def run
    last_n_digit = 37
    divisor = 10 ** @input_size
    loop do
      new_recipe = @array[@e1_pos] + @array[@e2_pos]
      if new_recipe > 9
        new_digit = new_recipe / 10
        last_n_digit = last_n_digit * 10 + new_digit

        @array[@recipe_count] = new_digit
        @recipe_count += 1

        last_n_digit %= divisor
        check_last_n_digit(last_n_digit)
      end

      new_digit = new_recipe % 10
      last_n_digit = last_n_digit * 10 + new_digit
      @array[@recipe_count] = new_digit
      @recipe_count += 1

      last_n_digit %= divisor
      check_last_n_digit(last_n_digit)

      @e1_pos = (@e1_pos + 1 + @array[@e1_pos]) % @recipe_count
      @e2_pos = (@e2_pos + 1 + @array[@e2_pos]) % @recipe_count
    end
  end

  def check_last_n_digit(last_n_digit)
    if last_n_digit == @input
      puts "Last n digit #{last_n_digit} at recipe_count #{@recipe_count}"
      puts @recipe_count - @input_size
      exit
    end
  end
end

Solution.new.run
