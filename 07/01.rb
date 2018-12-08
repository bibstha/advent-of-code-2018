require 'set'
class Solution1
  MyNode = Struct.new(:parent_keys, :children_keys)

  def initialize
    @nodes = Hash.new { |h, k| h[k] = MyNode.new([], []) }
    @ready_node_keys = SortedSet.new
    @result = []

    parse_input
    build_ready_nodes
  end

  def parse_input
    input = File.readlines('input')
    # input = DATA.readlines
    regexp = /Step ([A-Z]) must be finished before step ([A-Z]) can/
    input.each do |line|
      matches = line.match(regexp)
      raise "No match for line: #{line}" unless matches

      parent_key = matches[1]
      child_key = matches[2]
      @nodes[parent_key].children_keys << child_key
      @nodes[child_key].parent_keys << parent_key
    end
  end

  def run
    loop do
      node_key = @ready_node_keys.first
      @result << node_key

      node = @nodes[node_key]

      node.children_keys.each do |child_key|
        child_node = @nodes[child_key]
        child_node.parent_keys.delete(node_key)
      end

      @nodes.delete(node_key)
      @ready_node_keys.delete(node_key)

      build_ready_nodes
      break if @ready_node_keys.empty?
    end

    puts @result.join
  end

  def build_ready_nodes
    @nodes.each do |k, node|
      @ready_node_keys << k if node.parent_keys.empty?
    end
  end
end

Solution1.new.run

__END__
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
