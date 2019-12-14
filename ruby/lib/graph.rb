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
    adjacency_list[to].add(from)
    self
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
end
