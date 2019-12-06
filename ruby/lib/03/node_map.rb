class NodeMap
  attr_reader :path_id

  def initialize
    @visited_by_point = Hash.new { |h, k| h[k] = 0 }
    @points_by_path = Hash.new { |h, k| h[k] = [] }
    @points_by_count = Hash.new  { |h, k| h[k] = [] }
    @steps = 0
  end

  def visit(point)
    @steps += 1
    the_point = stored_point(point)
    the_point.store_path_position(@steps, path_id)

    unless already_seen_on_path?(the_point)
      @points_by_path[point_key(the_point)].push(path_id)
      @points_by_count[@visited_by_point[point_key(the_point)] += 1].push(the_point)
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

  private

  def stored_point(point)
    @points_by_count[@visited_by_point[point_key(point)]].push(point).
      detect { |stored_point| stored_point  == point }
  end

  def point_key(point)
    "#{point.x},#{point.y}"
  end

  def already_seen_on_path?(point)
    @points_by_path[point_key(point)].include? path_id
  end
end
