module Operations
  class Instruction
    attr_reader :opcode, :input_modes
    def initialize(tape_value)
      a, b, c, d, e = ('%05i' % tape_value).split('').map(&:to_i)

      @opcode = (d*10) + e
      @input_modes = { 1 => c, 2 => b, 3 => a}
    end

    def position
      lambda { |tape, location| tape.move_to(location) }
    end

    def immediate
      lambda { |_tape, value| value }
    end
  end
end
