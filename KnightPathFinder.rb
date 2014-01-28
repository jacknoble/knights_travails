# require "TreeNode.rb"
require "matrix"

class KnightPathFinder
  def initialize(position)
    position = Vector.elements(position)
    @move_tree = build_move_tree(position)
  end

  def build_move_tree(position)
    visited = []
    start_node = TreeNode.new(position)
    queue = [start_node]
    until queue.empty?
      next_node = queue.shift
      new_move_positions(next_node.value).each do |position|
        unless visited.include?(position)
          visited << position
          child = TreeNode.new(position)
          next_node.add_child(child)
          queue << child
        end
      end
    end

    start_node
  end

  def new_move_positions(old_position)
    shifts = ([1,-1].product([-2,2]) + [2,-2].product([-1,1]))
    shifts.map!{ |vector| Vector.elements(vector)}
    new_positions = []
    shifts.each do |shift|
      new_positions << (shift + old_position)
    end

    new_positions.select do |position|
      position[0] < 8 && position[0] > -1 && position[1] < 8 && position[1] > -1
    end
  end

  def find_path(target_pos)
    @move_tree.dfs(Vector.elements(target_pos)).path.map(&:to_a)
  end
end
