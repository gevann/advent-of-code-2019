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
    value = motion.chars.last.to_i
    dir = motion.chars.first

    (1..value).map { |v| translate("#{dir}#{v}") }
  end

  def ==(other)
    x == other.x && y == other.y
  end

  private

  def coordinates_for(motion)
    dir, str_int = motion.chars

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
