require 'node'
require 'set'

class Graph
  attr_reader :orbit_count, :adjacency_list, :orbits

  def initialize
    @orbit_count = 0
    @adjacency_list = Hash.new { |h, k| h[k] = Set.new }
    @roots = Hash.new { |h, k| h[k] = k }
  end

  def insert_edge(from, to)
    roots[to] = roots[from]
    adjacency_list[from].add(to)
    adjacency_list[to].add(from)
    self
  end

  def root(sym)
    helper = lambda do |node|
      if roots[node] == node
        node
      else
        roots[node] = helper.(roots[node])
      end
    end
    helper.(sym)
  end

  def count_orbits
    adjacency_list.keys.inject(0) do |acc, from|
      acc + BFS(from: from, to: :COM).flat_map(&:name).length - 1
    end
  end

  def distance(from:, to:)
    BFS(from: from, to: to).flat_map(&:name).length - 3
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

  attr_reader :roots
end
