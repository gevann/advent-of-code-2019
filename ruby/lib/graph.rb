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

    from_node.add_children(to_node)

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

  def distance(from:, to:)
    from_node = BFS(name: from, start_node: roots.first)
    to_node = BFS(name: to, start_node: roots.first)

    f = from_node.flat_map {|e| e.name }
    f.pop
    t = to_node.flat_map { |e| e.name }
    t.pop

    shared_length = f.zip(t).select {|a, b| a == b}.length
    f.length + t.length - 2 * shared_length
  end

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
      v.children.each do |edge|
        stack.push(edge)
      end
    end
  end

  def BFS(name:, start_node:)
    queue   = []
    queue.push(start_node)
    visited = Set[start_node]

    while queue.any?
      node = queue.shift

      if node.name == name
        return node
      else
        node.children.each do |child|
          unless visited.include? child
            child.parent = node
            queue.push(child)
          end
        end
      end
    end
  end

  private

  def merge_trees(node)
    roots.delete(node)
  end
end
