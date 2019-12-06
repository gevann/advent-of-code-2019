class Point
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def translate(motion)
    self.class.new(*coordinates_for(motion))
  end

  def points_in_translation(motion)
    dir = motion[0]
    str_int = motion[1..-1]

    value = str_int.to_i

    (1..value).map { |v| translate("#{dir}#{v}") }
  end

  def ==(other)
    x == other.x && y == other.y
  end

  private

  def coordinates_for(motion)
    dir = motion[0]
    str_int = motion[1..-1]

    value = str_int.to_i

    scalar =
      if %w(L D).include? dir.upcase
        -1
      else
        1
      end

    if %w(L R).include? dir.upcase
      [x + (scalar * value), y]
    else
      [x, y + (scalar * value)]
    end
  end
end
