class Solution
  def initialize
    @input = 2018
    @input = 409551
    @total_array_size = @input + 10
    @array = Array.new(@total_array_size)
    @array[0] = 3
    @array[1] = 7
    @e1_pos = 0
    @e2_pos = 1
    @recipe_count = 2
  end

  def run
    loop do
      # puts "#{@e1_pos}. #{@e2_pos} = #{@array.inspect}"
      new_recipe = @array[@e1_pos] + @array[@e2_pos]

      r1 = new_recipe / 10
      r2 = new_recipe % 10

      if r1 != 0
        @array[@recipe_count] = r1
        @recipe_count += 1
      end

      @array[@recipe_count] = r2
      @recipe_count += 1

      @e1_pos = (@e1_pos + 1 + @array[@e1_pos]) % @recipe_count
      @e2_pos = (@e2_pos + 1 + @array[@e2_pos]) % @recipe_count

      if @recipe_count >= @total_array_size
        puts @array[@input, 10].join
        break
      end
    end
  end

end

Solution.new.run
