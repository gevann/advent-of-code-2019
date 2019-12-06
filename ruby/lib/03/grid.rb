require '03/point'
require '03/node_map'

class Grid
  attr_reader :origin, :intersection_count

  def initialize(origin: Point.new(0, 0), intersection_count: 2)
    @origin = origin
    @nodemap = NodeMap.new
    @intersection_count = intersection_count
  end

  def trace(path)
    @nodemap.path_id = path.object_id

    helper = lambda do |the_path, source|
      if the_path.any?
        motion = path.shift
        points = source.points_in_translation(motion)
        points.each { |p| @nodemap.visit(p) }
        helper.(path, points.last)
      end
    end
    helper.(path, origin)
    @nodemap
  end

  def intersections
    @nodemap.visit_count(intersection_count)
  end

  def path_position(point)
    @nodemap.path_position(point)
  end
end
