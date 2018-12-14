require 'set'

class Solution
  INTERSECTION_ROTATIONS = %i(left straight right)
  DIRECTION_ROTATIONS = %w(< ^ > v)
  VERTICAL_DIRECTIONS = %w(^ v)

  class Cart
    attr_accessor :x, :y, :crashed
    def initialize(x, y, direction)
      @x = x
      @y = y
      @intersectional_rotation = INTERSECTION_ROTATIONS.dup
      @directions = DIRECTION_ROTATIONS.rotate(DIRECTION_ROTATIONS.find_index(direction))
      @crashed = false
    end

    def <=>(other)
      return y <=> other.y if (y <=> other.y) != 0
      return x <=> other.x if (x <=> other.x) != 0
      return 0
    end

    def direction
      @directions.first
    end

    def rotate(direction)
      case direction
      when :left
        @directions.rotate!(-1)
      when :right
        @directions.rotate!(1)
      when :intersection
        current_rotation = @intersectional_rotation.first
        @intersectional_rotation.rotate!(1)
        rotate(current_rotation)
      end
    end
  end

  def initialize
    @input = File.readlines('input').map!(&:chomp)
    # @input = DATA.readlines.map!(&:chomp)
    @col_size = @input.first.size
    @row_size = @input.size

    @track = Array.new(@col_size) { Array.new(@row_size) }
    @cart_positions = Hash.new { |h, k| h[k] = {} }

    @current_tick_carts = SortedSet.new
    @next_tick_carts = SortedSet.new

    parse_input
  end

  def parse_input
    @input.each_with_index do |line, j|
      line.each_char.with_index do |char, i|
        track_char, is_cart = case char
        when '^', 'v'
          ['|', true]
        when '<', '>'
          ['-', true]
        else
          [char, false]
        end

        @track[i][j] = track_char
        if is_cart
          cart = Cart.new(i, j, char)
          @current_tick_carts << cart
          @cart_positions[i][j] = cart
        end
      end
    end
  end

  def run
    i = 0
    loop do
      tick
      if @current_tick_carts.one? { |cart| !cart.crashed }
        puts "Remaining cart is = #{@current_tick_carts.find { |cart| !cart.crashed }.inspect}"
        break
      end
      i += 1
    end
  end

  def tick
    @current_tick_carts.each do |cart|
      move_cart(cart) unless cart.crashed
      @next_tick_carts << cart
      @current_tick_carts.delete(cart)
    end
    @temp = @current_tick_carts
    @current_tick_carts = @next_tick_carts
    @next_tick_carts = @temp
  end

  def move_cart(cart)
    old_x, old_y = cart.x, cart.y
    case cart.direction
    when '>'
      cart.x += 1
    when '<'
      cart.x -= 1
    when '^'
      cart.y -= 1
    when 'v'
      cart.y += 1
    else
      raise "Bad cart direction"
    end

    if @cart_positions[cart.x][cart.y]
      other_cart = @cart_positions[cart.x][cart.y]
      other_cart.crashed = true
      cart.crashed = true
      puts "Collision detected for #{cart.inspect}"
      @cart_positions[old_x][old_y] = nil
      @cart_positions[cart.x][cart.y] = nil
    else
      @cart_positions[old_x][old_y] = nil
      @cart_positions[cart.x][cart.y] = cart
    end

    change_direction(cart)
  end

  def change_direction(cart)
    current_track = @track[cart.x][cart.y]
    case current_track
    when '\\'
      if VERTICAL_DIRECTIONS.include?(cart.direction)
        cart.rotate(:left)
      else
        cart.rotate(:right)
      end
    when '/'
      if VERTICAL_DIRECTIONS.include?(cart.direction)
        cart.rotate(:right)
      else
        cart.rotate(:left)
      end
    when '+'
      cart.rotate(:intersection)
    end
  end

  def print_matrix
    @row_size.times do |j|
      @col_size.times do |i|
        if (cart = @cart_positions[i][j])
          print cart.direction
        else
          print @track[i][j]
        end
      end
      puts
    end
  end
end

Solution.new.run

__END__
/>--\        
v   |  /----\
| /-+--+-\  |
| | |  | |  |
\-+-/  \-+--/
  \------/   
