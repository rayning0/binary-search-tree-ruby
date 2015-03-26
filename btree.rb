# Binary Search Tree

class Node
  include Enumerable

  # module that gives you the ability to directly compare the data
  # values of node using <, <=, ==, >, >=, and between? instance methods.
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
  end

  def each(&block)
    left.each(&block) if left
    block.call(self)
    right.each(&block) if right
  end

  def values
    self.collect { |node| node.data }
  end

  def include?(data)
    values.include?(data)
  end

  def count_nodes_between(a, b)
    values.select { |data| data.between?(a, b) }.size
  end

  # Ruby can compare two Nodes and tell which one is greater.
  # This allows it to implement sort, min and max methods.
  def <=>(other_node)
    data <=> other_node.data
  end

  def insert(data)
    if data <= self.data
      do_insert('left', data)
    else
      do_insert('right', data)
    end
  end

  def do_insert(side, data)
    if send(side)
      send(side).insert(data)
    else
      send("#{side}=", Node.new(data))
    end
  end

  # def find_node(node, data)
  #   if self.data == data
  #     return self
  #   elsif data < self.data
  #     find_node(node.left, data)
  #   else
  #     find_node(node.right, data)
  #   end
  # end

end

root = Node.new(7)
root.left = Node.new(3)
root.right = Node.new(12)
root.insert 9
root.insert 2
root.insert 8
puts root.values
puts root.include? 10
puts root.include? 2
puts root.include? 8
puts root.include? 12
puts root.include? 6

# Enumerable provides some of these methods
=begin
  puts "SUM"
  puts root.inject(0) { |memo, val| memo += val.data }
  puts "MAX"
  puts root.max.data
  puts "SORT"
  puts root.sort.map(&:data)

Comparable provides methods like <, <=, >, ==, between? to compare data values of Nodes
  root = Node.new(7)
  root.left = Node.new(3)
  root.right = Node.new(12)

  root.between?(root.left, root.right) # true
  root.left < root.right # true
=end