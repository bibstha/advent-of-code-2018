# inputs = File.readlines("input")
# inputs = inputs.sort!
# File.write "input_sorted", inputs.join

inputs = File.readlines("input_sorted")
# inputs = DATA.readlines
$guard_shifts = Hash.new { |h, k| h[k] = Array.new(60, 0) }

# def build_hour_map()
# end

def parse_guard(row)
  guard = row.match /Guard #([0-9]+) /
  return guard[1].to_i if guard
end

def parse_shift(guard_number, shift)
  return if shift.empty?

  last_sleep = nil
  last_awake = 0
  shift.each do |event|
    if (sleep = event.match(/:([0-9]{2})\] falls/))
      last_sleep = sleep[1].to_i
    elsif (wake_up = event.match(/:([0-9]{2})\] wakes/))
      last_awake = wake_up[1].to_i
      raise "Wakes up without sleep: #{guard_number} #{shift}" if last_sleep.nil?

      (last_sleep...last_awake).each do |i|
        $guard_shifts[guard_number][i] += 1
      end
    else
      raise "Found weird event #{event}"
    end
  end
end

shift = []

total = inputs.size
last_guard_number = nil
inputs.each_with_index do |input, i|
  guard_number = parse_guard(input)

  shift << input if guard_number.nil?

  next unless guard_number || i == total - 1

  parse_shift(last_guard_number, shift)
  last_guard_number = guard_number
  shift = []
end

guard_num, = $guard_shifts.map { |k, v| [k, v.sum] }.max_by { |k, v| v }
max_value = $guard_shifts[guard_num].max
index = $guard_shifts[guard_num].find_index(max_value)

# Strategy1
puts "Strategy1: Found Guard_num #{guard_num} with max_value #{max_value} at index #{index}"
puts "#{guard_num} * #{index} = #{guard_num * index}"

puts

# Strategy2
guard_num, max_value = $guard_shifts.map { |k, v| [k, v.max] }.max_by { |k, v| v }
index = $guard_shifts[guard_num].find_index(max_value)
# $guard_shifts.each do |gn, s|
#   puts "%2d %s" % [gn, s.join]
# end
puts "Strategy2: Found Guard_num #{guard_num} with max_value #{max_value} at index #{index}"
puts "#{guard_num} * #{index} = #{guard_num * index}"


# Solution: 12169

__END__
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:23] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
