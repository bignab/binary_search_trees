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

  # def delete(value, node = @root)
  #   return node if node.nil?

  #   if node.value > value
  #     delete(value, node.right)
  #   elsif node.value < value
  #     delete(value, node.left)
  #   else
  #     if node.left.nil? && node.right.nil?

  #     elsif node.left.nil?
  #     elsif node.right.nil?
  #     else

  #     end
  #   end
  #   # node to be deleted is the leaf
  #   # node to be deleted has one child
  #   # node to be deleted has two children
  # end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if node.data > value
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(node = @root, arr = [], queue = [], &block)
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    arr.push(node.data)
    level_order(queue.shift, arr, queue) unless queue.empty?
    if block_given?
      arr.each(&block)
    else
      arr
    end
  end

  def preorder(node = @root, arr = [], &block)
    arr.push(node.data)
    preorder(node.left, arr) unless node.left.nil?
    preorder(node.right, arr) unless node.right.nil?
    if node == @root
      block_given? ? arr.each(&block) : arr
    end
  end

  def inorder(node = @root, arr = [], &block)
    inorder(node.left, arr) unless node.left.nil?
    arr.push(node.data)
    inorder(node.right, arr) unless node.right.nil?
    if node == @root
      block_given? ? arr.each(&block) : arr
    end
  end

  def postorder(node = @root, arr = [], &block)
    postorder(node.left, arr) unless node.left.nil?
    postorder(node.right, arr) unless node.right.nil?
    arr.push(node.data)
    if node == @root
      block_given? ? arr.each(&block) : arr
    end
  end

  def height(node, level = 0)
    return level if node.nil?
    return level if node.left.nil? && node.right.nil?

    level += 1
    [height(node.left, level), height(node.right, level)].max
  end

  def depth(target_node, current_node = @root, level = 0)
    return 0 if current_node.nil?
    return level if current_node == target_node

    level += 1
    [depth(target_node, current_node.left, level), depth(target_node, current_node.right, level)].max
  end

  def balanced?(node = @root, left = true, right = true)
    return true if node.left.nil? && node.right.nil?
    return false unless (height(node.left) - height(node.right)).abs < 2

    left = balanced?(node.left) unless node.left.nil?
    right = balanced?(node.right) unless node.right.nil?
    left && right
  end

  def rebalance
    arr = level_order
    @root = build_a_tree(arr)
  end
end

test_array = [1, 2, 3, 5, 6, 3, 34, 134, 132, 23, 63]
p test_array.uniq.sort
puts
test_tree = Tree.new(test_array)
test_tree.insert(137)
test_tree.insert(139)
test_tree.insert(147)
test_tree.pretty_print
p test_tree.find(134)
p test_tree.inorder
p test_tree.depth(test_tree.find(2))
test_tree.rebalance
p test_tree.balanced?
test_tree.pretty_print
# test_tree.preorder { |i| puts "#{i}!" }
