require_relative "tree_node.rb"

class KnightPathFinder
  attr_reader :visited_positions
  def initialize(pos)
    @current_pos = pos
    @board = Array.new(8) { Array.new(8) }
    @visited_positions = {pos => true}
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)

    possible_moves = possible_moves.select do |pos|
      pos.all? do |num|
        num >= 0 && num < @board.length && !@visited_positions[pos]
      end
    end

    possible_moves.each { |pos| @visited_positions[pos] = true }

    possible_moves
  end

  def self.valid_moves(pos)
    result = []
    x, y = pos
    (-2..2).each do |x_add|
      next if x_add == 0
      (-2..2).each do |y_add|
        next if y_add == 0
        result << [x + x_add, y + y_add] unless x_add.abs == y_add.abs
      end
    end

    result
  end

  def build_move_tree
    queue = [PolyTreeNode.new(@current_pos)]
    @first_node = queue[0]

    until queue.empty?
      node = queue.shift
      moves = new_move_positions(node.value)

      moves.each do |child_move|
        child_node = PolyTreeNode.new(child_move)
        child_node.parent = node
        queue << child_node
      end
    end
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def find_path_dfs(end_pos)
    @first_node.dfs(end_pos)
  end

  def find_path_bfs(end_pos)
    @first_node.bfs(end_pos)
  end

  def trace_path_back(end_pos)
    result = []
    node = find_path_dfs(end_pos)
    until node.parent.nil?
      result << node.value
      node = node.parent
    end

    result << node.value
    result
  end
end

game = KnightPathFinder.new([0, 0])
# game.build_move_tree.each {|node| p node.value}
game.build_move_tree
p game.trace_path_back([7, 7])
