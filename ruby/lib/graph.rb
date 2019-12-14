require 'node'
require 'set'

class Graph
  attr_reader :roots, :orbit_count, :adjacency_list

  def initialize
    @orbit_count = 0
    @adjacency_list = Hash.new { |h, k| h[k] = Set.new }
  end

  def insert_edge(from, to)
    adjacency_list[from].add(to)
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

  def BFS(from:, to:)
    queue   = []
    queue.push(Node.new(name: from))
    visited = Set[from]

    while queue.any?
      node = queue.shift

      if node.name == to
        return node
      else
        adjacency_list[node.name].each do |child|
          unless visited.include? child
            visited.add(child)
            child_node = Node.new(name: child)
            child_node.parent = node
            queue.push(child_node)
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
