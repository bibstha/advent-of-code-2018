class Solution1
  Node = Struct.new(:children, :metadata, :total_size, :metadata_sum, :special_sum)

  def initialize
    input = File.read('input')
    # input = DATA.read
    @input = input.tap(&:chomp!).split(' ').map!(&:to_i)
  end

  def run
    root_node = build_nodes(1, @input).first
    puts "Part1: Sum of all metadata = #{root_node.metadata_sum}"
    puts "Part2: Special sum of all metadata = #{root_node.special_sum}"
  end

  def build_nodes(count, input)
    child_count_pos = 0
    Array.new(count) do
      metadata_count_pos = child_count_pos + 1

      child_count = input[child_count_pos]
      metadata_count = input[metadata_count_pos]

      if child_count.zero?
        children = []
        metadata = input[metadata_count_pos + 1, metadata_count]
        node_size = 2 + metadata_count
        special_sum = metadata.sum
      else
        children = build_nodes(child_count, input[(child_count_pos + 2)..-1])
        children_size = children.sum(&:total_size)
        metadata = input[metadata_count_pos + children_size + 1, metadata_count]
        node_size = 2 + metadata_count + children_size

        special_sum = metadata.sum do |i|
          children[i-1] ? children[i-1].special_sum : 0
        end
      end

      child_count_pos += node_size
      metadata_sum = metadata.sum + children.sum(&:metadata_sum)
      Node.new(children, metadata, node_size, metadata_sum, special_sum)
    end
  end

  def sum_of_metadata(node)
    metadata_sum = node.metadata.sum
    return metadata_sum if node.children.empty?

    metadata_sum + node.children.sum { |child| sum_of_metadata(child) }
  end
end

Solution1.new.run

__END__
2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
