module Distance
  class Manhattan
    def self.calculate(point_a, point_b)
      (point_a.x - point_b.x).abs + (point_a.y - point_b.y).abs
    end
  end
end
