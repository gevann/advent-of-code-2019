class Node
  attr_reader(:name, :children)
  attr_accessor(:parent)

  def initialize(name:)
    @name     = name
    @children = []
    @parent   = nil
  end

  def leaf?
    children.any?
  end

  def add_children(nodes)
    collection = Array(nodes)
    children.concat(collection)
    self
  end

  def self.dfs_count(node)
    stack = []
    stack.push(node)
    count = -1

    while stack.any?
      v = stack.pop
      count += 1
      v.children.each { |edge| stack.push(edge) }
    end
    count
  end
end
