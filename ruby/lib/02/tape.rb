class Tape
  attr_reader :position, :value, :tape

  def initialize(tape)
    @tape = tape
    @position = 0
    @lower_boundry = -1
    @upper_boundry = tape.length
    read
  end

  def move_to(location)
    unless location < @upper_boundry && location > @lower_boundry
      raise ArgumentError, 'Location out of bounds'
    end

    @position = location
    read
  end

  # Returns a new array with <count> elements, starting
  # with the current position and moving forward until the
  # count is reached.
  #
  # @param count [Int] the number of elements to include in the
  # output array.
  def scan(count)
    scanned = tape.slice(position, count)
    move_to(position + count - 1)
    scanned
  end

  def write(value, location)
    move_to(location)
    tape[position] = value
    read
  end

  private

  def read
    @value = tape[position]
  end
end
