require 'node'

class Graph
  attr_reader :root

  def initialize(root)
    @root = root
  end

  def insert_edge(from, to)
    *path, node = dfs(from, root, [root])
    new_node = Node.new(name: to)
    node.add_nodes(new_node)
    path.map { |entry| entry.increment_indirect_count }
  end

  def dfs(name, node, path = [])
    if node.name == name
      path
    else
      node.directly_adjacent_nodes.each do |adjacent_node|
        n = dfs(name, adjacent_node, path + [adjacent_node])
        return n if n.last&.name == name
      end
    end
  end
end
