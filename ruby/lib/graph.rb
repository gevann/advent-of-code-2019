require 'node'
require 'set'

class Graph
  attr_reader :roots, :orbit_count

  def initialize
    @roots = Set.new
    @orbit_count = 0
  end

  def insert_edge(from, to)
    *from_path, from_node = roots.detect do |root|
      path = dfs(name: from, node: root)
      if path&.any?
        break(path)
      end
    end

    if from_node.nil?
      from_node = Node.new(name: from)
      roots.add(from_node)
    end

    *to_path, to_node = roots.find do |root|
      dfs(name: to, node: root)
    end
    to_node ||= Node.new(name: to)

    from_node.add_nodes(to_node)

    merge_trees(to_node)

    self
  end

  def count_orbits
    node = roots.first
    stack = []
    stack.push(node)

    while stack.any?
      v = stack.pop
      @orbit_count += Node.dfs_count(v)
      v.children.each { |edge| stack.push(edge) }
    end
    @orbit_count
  end

#1  procedure DFS-iterative(G,v):
  def dfs(name:, node:)
    stack = []
    stack.push(node)
    current_path = []

    while stack.any?
      v = stack.pop
      current_path.push(v)

      if v.name == name
        return current_path
      end
      v.children.each { |edge| stack.push(edge) }
    end
  end

  private

  def merge_trees(node)
    roots.delete(node)
  end
end
