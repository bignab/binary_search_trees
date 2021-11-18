# frozen_string_literal: true

# Represents a node in a Tree, with references to left and right subtrees and the root value.
class Node
  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# Represents the binary search tree and contains all associated nodes.
class Tree
  def initialize(arr)
    @root = build_a_tree(arr.uniq.sort)
  end

  def build_a_tree(arr)
    return nil if arr.empty?

    middle = (arr.length - 1) / 2
    Node.new(arr[middle], build_a_tree(arr[0...middle]), build_a_tree(arr[(middle + 1)..-1]))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    new_node = Node.new(value)
    current_node = @root
    node_assigned = false
    until node_assigned
      if current_node.data > value
        if current_node.left.nil?
          current_node.left = new_node
          node_assigned = true
        else
          current_node = current_node.left
        end
      elsif current_node.right.nil?
        current_node.right = new_node
        node_assigned = true
      else
        current_node = current_node.right
      end
    end
  end

  def delete(value)
    # TBD
  end
end

test_array = [1, 2, 3, 5, 6, 3, 34, 134, 132, 23, 63]
p test_array.uniq.sort
puts
test_tree = Tree.new(test_array)
test_tree.insert(22)
test_tree.pretty_print
