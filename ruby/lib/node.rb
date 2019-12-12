class Node
  attr_reader(
    :name,
    :directly_adjacent_nodes,
    :directly_adjacent_node_count,
    :indirectly_adjacent_node_count
  )

  def initialize(name:)
    @name                           = name
    @directly_adjacent_nodes        = []
    @directly_adjacent_node_count   = 0
    @indirectly_adjacent_node_count = 0
  end

  def add_nodes(nodes)
    collection = Array(nodes)
    directly_adjacent_nodes.concat(collection)
    @directly_adjacent_node_count += collection.length
    self
  end
end
