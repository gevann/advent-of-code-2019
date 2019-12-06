module Distance
  class Steps
    def self.calculate(point_a, point_b)
      point_a.path_position + point_b.path_position
    end
  end
end
