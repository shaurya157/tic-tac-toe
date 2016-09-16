class PolyTreeNode
  attr_accessor :value
  attr_reader :parent, :children

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) if @parent

    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child" if child_node.parent != self

    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      node = child.dfs(target_value)
      return node if node
    end
    nil
  end

  def bfs(target_value)
    arr = []
    arr << self

    until arr.empty?
      node = arr.shift

      return node if node.value == target_value
      arr += node.children
    end

    nil
  end
end
