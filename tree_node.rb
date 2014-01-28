class TreeNode
  attr_accessor :value, :parent, :position, :children

  def initialize(value=nil)
    @value = value
    @children = []
  end

  def left
    @children[0]
  end

  def right
    @children[1]
  end

  def left=(node)
    set_child(node, 0)
  end

  def right=(node)
    set_child(node, 1)
  end

  def detatch
    @parent = nil
    @position = nil
  end

  def set_child(new_child, position)
    if position == :left
      position = 0
    elsif position == :right
      position = 1
    end

    @children[position].detatch if @children[position]
    new_child.detatch
    new_child.position = position
    @children[position] = new_child
  end

  def add_child(added_child)
    added_child.parent = self
    @children << added_child
  end

  def dfs(value = nil, &prc)
    if block_given?
      return self if prc.call(self.value)
    else
      return self if self.value == value
    end

    return false if @children.empty?

    branch_search = false

    @children.each do |child|
      found = child.dfs(value, &prc)
      if found
        branch_search = found
        break
      end
    end

    branch_search
  end

  def bfs(value=0, &prc)
    queue = [self]
    until queue.empty?
      next_node = queue.shift
      if block_given?
        return next_node if prc.call(next_node.value)
      else
        return next_node if next_node.value == value
      end
      next_node.children.each { |node| queue << node }
    end
    false
  end

  def path
    return [self.value] if parent.nil?
    self.parent.path + [self.value]
  end
end