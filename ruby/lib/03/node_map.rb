class NodeMap
  attr_reader :path_id

  def initialize
    @visited_by_point = Hash.new { |h, k| h[k] = 0 }
    @points_by_path = Hash.new { |h, k| h[k] = [] }
    @points_by_count = Hash.new  { |h, k| h[k] = [] }
    @path_positions =  Hash.new { |h, k| h[k] = {} }
    @steps = 0
  end

  def visit(point)
    @steps += 1
    point.store_path_position(@steps, path_id)

    unless already_seen_on_path?(point)
      @path_positions[point_key(point)].store(path_id, @steps)
      @points_by_path[point_key(point)].push(path_id)
      @points_by_count[@visited_by_point[point_key(point)] += 1].push(point)
    end
  end

  def visit_count(count)
    @points_by_count[count]
  end

  def [](point)
    @visited_by_point[point_key(point)]
  end

  def path_id=(id)
    @path_id = id
    @steps = 0
  end

  def path_position(point)
    @path_positions[point_key(point)].values
  end

  private

  def point_key(point)
    "#{point.x},#{point.y}"
  end

  def already_seen_on_path?(point)
    @points_by_path[point_key(point)].include? path_id
  end
end
