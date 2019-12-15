require 'node'
require 'set'

class Graph
  attr_reader :adjacency_list, :orbits_by_com

  def initialize
    @adjacency_list = Hash.new { |h, k| h[k] = Set.new }
    @roots = Hash.new { |h, k| h[k] = k }
    @orbits_by_com = {}
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

  def count_orbits(com = :COM)
    orbits_by_com[com] ||=
      dist_to_root = {}
      adjacency_list.keys.sort_by{ |k| adjacency_list[k].size}.inject(0) do |acc, from|
      if dist_to_root[from].nil?
        path = BFS(from: from, to: com).flat_map(&:name)
        len = path.length - 1

        path.each_with_index do |sym, idx|
          break if dist_to_root[sym]
          dist_to_root[sym] = len - idx
        end
      end
      acc + dist_to_root[from]
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
