require 'set'
class Solution1
  MyNode = Struct.new(:parent_keys, :children_keys, :started)

  Work = Struct.new(:start_sec, :type, :key) do
    def <=>(other)
      sec_compare = start_sec <=> other.start_sec
      return sec_compare if sec_compare != 0

      type_compare = type <=> other.type
      return type_compare if type_compare != 0

      key <=> other.key
    end
  end

  RELEASE = '1release'.freeze
  STEP = '2step'.freeze
  WORKER_COUNT = 5

  def initialize
    @nodes = Hash.new { |h, k| h[k] = MyNode.new([], [], false) }

    @current_time = 0
    @worker_states = (0...WORKER_COUNT).map { |i| [i, nil] }.to_h
    @remaining_work = SortedSet.new

    @result = []

    parse_input
    build_work
  end

  def parse_input
    input = File.readlines('input')
    # input = DATA.readlines
    regexp = /Step ([A-Z]) must be finished before step ([A-Z]) can/
    input.each do |line|
      matches = line.match(regexp)
      parent_key = matches[1]
      child_key = matches[2]
      @nodes[parent_key].children_keys << child_key
      @nodes[child_key].parent_keys << parent_key
    end
  end

  def build_work
    @nodes.each do |k, node|
      if node.started == false && node.parent_keys.empty?
        @remaining_work << Work.new(@current_time, STEP, k)
        node.started = true
      end
    end
  end

  def run
    loop do
      work = next_work
      @current_time = work.start_sec if @current_time < work.start_sec

      node_key = work.key

      if work.type == RELEASE
        @result << node_key
        @node = @nodes.delete(node_key)

        @node.children_keys.each do |child_key|
          @nodes[child_key].parent_keys.delete(work.key)
        end

        worker_index = @worker_states.find_index { |k, v| v == node_key }
        @worker_states[worker_index] = nil
      elsif work.type == STEP
        worker_index = next_worker
        @worker_states[worker_index] = node_key

        @work_time = @current_time + (node_key.ord - 64 + 60)
        @remaining_work << Work.new(@work_time, RELEASE, node_key)
      end

      @remaining_work.delete(work)

      break if @nodes.empty?

      build_work
    end

    puts @result.join
    puts "Current time #{@current_time}"
  end

  def next_worker
    @worker_states.find { |_, v| v.nil? }.first
  end

  def next_work
    if @worker_states.none? { |_, v| v.nil? }
      @remaining_work.find { |work| work.type == RELEASE }
    else
      @remaining_work.first
    end
  end
end

Solution1.new.run

# Answer 898

__END__
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
